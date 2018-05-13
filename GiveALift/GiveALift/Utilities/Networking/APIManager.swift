//
//  APIManager.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class APIManager: APIManagerType {
    
    static let shared: APIManagerType = APIManager()
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    
    // MARK: Initializers
    
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder()) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func login(email: String, password: String, completion: @escaping APIResultBlock<GALUserLogin>) {
        let body = ["username": email, "password": password]
        requestBuilder.POSTRequest(withURL: urlBuilder.loginURL(), withData: body, authToken: nil) { (result) in
            switch result {
            case .Success(result: let result):
                    do  {
                        let decoder = JSONDecoder()
                        let galUserLogin = try decoder.decode(GALUserLogin.self, from: result)
                        DispatchQueue.main.async {
                            completion(APIResult.Success(result: galUserLogin))
                        }
                    } catch {
                        print(error)
                }
            case .Error(error: let error):
                    DispatchQueue.main.async {
                        completion(APIResult.Error(error: error))
                }
            }
        }
    }
    
    func register(request: RegisterRequest, completion: @escaping APIResultBlock<Data>) {
        requestBuilder.POSTRequest(withURL: urlBuilder.registerURL(), withData: request, authToken: nil) { (result) in
            switch result {
            case .Error(error: let error):
                completion(APIResult.Error(error: error))
            case .Success(result: let result):
                completion(APIResult.Success(result: result))
            }
        }
    }
    
    func addRoute(route: AddRoute) {
        let stop1 = RouteLocation()
        stop1.city = AddRouteCity()
        stop1.city.cityId = 405
        stop1.placeOfMeeting = "siusiaczek"
        stop1.date = "2018-05-08 22:45"
        let stop2 = RouteLocation()
        stop2.city = AddRouteCity()
        stop2.city.cityId = 407
        stop2.placeOfMeeting = "siusiaczek"
        stop2.date = "2018-05-08 22:55"
        route.stops.append(stop2)
        route.stops.append(stop1)
        requestBuilder.POSTRequest(withURL: urlBuilder.addRouteURL(), withData: route, authToken: User.shared.token) { (result) in
            switch result {
            case .Error(error: let error):
                print(error)
                print(error.localizedDescription)
            case .Success(result: let result):
                print(result)
            }
        }
    }
}
