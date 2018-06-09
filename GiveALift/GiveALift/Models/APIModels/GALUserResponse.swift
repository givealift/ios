//
//  GALUserResponse.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let galUserResponse: GalUserResponse
    let authToken: AuthToken
}

struct GalUserResponse: Decodable {
    let galUserId: Int
    let login: String
    let facebookId: String?
}

struct AuthToken: Decodable {
    let token: String
}
