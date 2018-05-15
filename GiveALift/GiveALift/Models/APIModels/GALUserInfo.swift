//
//  GALUserInfo.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct GALUserInfo: Codable {
    let address: String?
    let birthYear: Int
    let email, firstName, gender, lastName: String
    let phone: String
    let rate: Int?
}