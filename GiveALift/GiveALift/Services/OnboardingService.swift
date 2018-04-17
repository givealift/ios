//
//  OnboardingService.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class OnboardingService {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    
    // MARK: Initializers
    
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder()) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func login(email: String, password: String, completion: @escaping APIResultBlock<Response>) {
        let body = ["username": email, "password": password]
        requestBuilder.POSTRequest(withURL: urlBuilder.loginURL(), withData: body, authToken: nil) { (result) in
            switch result {
            case .Success(result: let result):
                do  {
                    let decoder = JSONDecoder()
                    let galUserResponse = try decoder.decode(Response.self, from: result)
                    completion(APIResult.Success(result: galUserResponse))
                } catch {
                    print(error)
                }
            case .Error(error: let error):
                completion(APIResult.Error(error: error))
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping APIResultBlock<Response>) {
        let body = ["username": email, "password": password]
        
        
    }
}
