//
//  OnboardingService.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol OnboardingServiceDelegate: class {
    func onboardingService(error: APIError)
    func onboardingService(user: GALUserLogin, result: RegisterRequest)
}

final class OnboardingService {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    weak var delegate: OnboardingServiceDelegate?
    
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
                    self?.delegate?.onboardingService(error: error)
                }
            }
        }
    }
    
    func getUserInfo(user: GALUserLogin) {
        requestBuilder.GETRequest(withURL: urlBuilder.userInfoURL(id: user.userID), authToken: user.token) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.delegate?.onboardingService(error: error)
                }
            case .Success(result: let result):
                do  {
                    let decoder = JSONDecoder()
                    let userInfo = try decoder.decode(RegisterRequest.self, from: result)
                    DispatchQueue.main.async {
                        self?.delegate?.onboardingService(user: user, result: userInfo)
                    }
                } catch {
                    fatalError("Decoding  failed")
                }
            }
        }
    }
}
