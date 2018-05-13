//
//  GALUserLogin.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct GALUserLogin: Codable {
    let userID: Int
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case token
    }
}
