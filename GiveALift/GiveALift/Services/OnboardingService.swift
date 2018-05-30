//
//  OnboardingService.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol OnboardingServiceErrorDelegate: class {
    func onboardingService(error: APIError)
}

protocol OnboardingServiceRegisterDelegate: class, OnboardingServiceErrorDelegate {
    func onboardingService(status: Bool)
}

protocol OnboardingServiceLoginDelegate: class, OnboardingServiceErrorDelegate {
    func onboardingService(user: GALUserLogin, userInfo: GALUserInfo)
}

final class OnboardingService {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    weak var loginDelegate: OnboardingServiceLoginDelegate?
    weak var registerDelegate: OnboardingServiceRegisterDelegate?
    
    // MARK: Initializers
    
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder()) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func login(email: String, password: String) {
        let body = ["username": email, "password": password]
        requestBuilder.POSTRequest(withURL: urlBuilder.loginURL(), withData: body, authToken: nil) { [weak self] (result) in
            switch result {
            case .Success(result: let result):
                do  {
                    let decoder = JSONDecoder()
                    let galUserLogin = try decoder.decode(GALUserLogin.self, from: result)
                    self?.getUserInfo(user: galUserLogin)
                } catch {
                    fatalError("Decoding GalSUerLogin failed")
                }
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.loginDelegate?.onboardingService(error: error)
                }
            }
        }
    }
    
    func getUserInfo(user: GALUserLogin) {
        requestBuilder.GETRequest(withURL: urlBuilder.userInfoURL(id: user.userID), authToken: user.token) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.loginDelegate?.onboardingService(error: error)
                }
            case .Success(result: let result):
                do  {
                    print(String(data: result, encoding: String.Encoding.utf8))
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let userInfo = try decoder.decode(GALUserInfo.self, from: result)
                    DispatchQueue.main.async {
                        self?.loginDelegate?.onboardingService(user: user, userInfo: userInfo)
                    }
                } catch {
                    print(error)
                    fatalError("Decoding  failed")
                }
            }
        }
    }
    
    func register(request: RegisterRequest) {
        print("tak wygląda request")
        print(request)
        requestBuilder.POSTRequest(withURL: urlBuilder.registerURL(), withData: request, authToken: nil) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.registerDelegate?.onboardingService(error: error)
                }
            case .Success(result: let result):
                DispatchQueue.main.async {
                    self?.registerDelegate?.onboardingService(status: true)
                }
            }
        }
    }
}
