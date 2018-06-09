//
//  GALRegisterResponse.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct GALRegisterResponse: Decodable {
    let galUserId: Int
    let login: String
    let facebookId: String?
}
