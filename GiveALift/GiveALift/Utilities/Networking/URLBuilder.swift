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
    
    func loginURL() -> URL {
        let urlString = mainURL + "/api/authenticate"
        return URL(string: urlString)!
    }
    
    func registerURL() -> URL {
        let urlString = mainURL + "/api/user/signup"
        return URL(string: urlString)!
    }
    
    func searchRouteURL(from: Int, to: Int, date: Date) -> URL {
        let urlString = mainURL + "/api/route?from=\(from)&to=\(to)&date=\(date)"
        print(urlString)
        return URL(string: urlString)!
    }
}
