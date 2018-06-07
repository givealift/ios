//
//  URLBuilder.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class URLBuilder: URLBuilderType {
    
    private let mainURL = "http://mysterious-lowlands-82501.herokuapp.com"
    
    func userReservedRoutes(userID: Int) -> URL {
        let urlString = mainURL + "/api/route/rides/\(userID)"
        return URL(string: urlString)!
    }
    
    func resignURL(routeID: Int, userID: Int) -> URL {
        let urlString = mainURL + "/api/route/\(routeID)/passenger/\(userID)"
        return URL(string: urlString)!
    }
    
    func userPhotoURL(userID: Int) -> URL {
        let urlString = mainURL + "/api/user/photo/\(userID)"
        return URL(string: urlString)!
    }
    
    func updateRoute(routeID: Int) -> URL {
        let urlString = mainURL + "/api/route/\(routeID)"
        return URL(string: urlString)!
    }
    
    func userRoutes(userID: Int) -> URL {
        let urlString = mainURL + "/api/user/route/\(userID)?page=0"
        return URL(string: urlString)!
    }
    
    func editUserInfoURL(userID: Int) -> URL {
        let urlString = mainURL + "/api/user/edit/\(userID)"
        return URL(string: urlString)!
    }
    
    func resere(routeID: Int) -> URL {
        let urlString = mainURL + "/api/route/\(routeID)/passenger"
        return URL(string: urlString)!
    }
    
    func userInfoURL(id: Int) -> URL {
        let urlString = mainURL + "/api/user/\(id)"
        return URL(string: urlString)!
    }
    
    func userPublicInfoURL(id: Int) -> URL {
        let urlString = mainURL + "/api/user/public/\(id)"
        return URL(string: urlString)!
    }
    
    func addRouteURL() -> URL {
        let urlString = mainURL + "/api/route"
        return URL(string: urlString)!
    }
    
    func loginURL() -> URL {
        let urlString = mainURL + "/api/authenticate"
        return URL(string: urlString)!
    }
    
    func registerURL() -> URL {
        let urlString = mainURL + "/api/user/signup"
        return URL(string: urlString)!
    }
    
    func searchRouteURL(from: Int, to: Int, date: String) -> URL {
        let urlString = mainURL + "/api/route/search?from=\(from)&to=\(to)&date=\(date)"
        print(urlString)
        return URL(string: urlString)!
    }
    
}
