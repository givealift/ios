//
//  RegisterRequest.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct RegisterRequest: Codable {
    let address: String
    let birthYear: Int
    let email, firstName, gender, lastName: String
    let password, phone: String
    let rate: Int
}
