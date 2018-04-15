//
//  URLBuilder.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class URLBuilder: URLBuilderType {
    private let mainURL = "https://mysterious-lowlands-82501.herokuapp.com"
    
    func loginURL() -> URL {
        let urlString = mainURL + "api/authenticate"
        return URL(string: urlString)!
    }
}
