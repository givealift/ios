//
//  GALUserPublicResponse.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 31.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct GalUserPublicResponse: Codable {
    let userID: Int
    let firstName, lastName, email, phone: String
    let gender: String?
    let rate: Int?
    let birthYear: Date
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case birthYear = "birthDate"
        case firstName, lastName, email, phone, gender, rate
    }
    
    func toGALUserInfo() -> GALUserInfo {
        return GALUserInfo(address: "", birthDate: self.birthYear, email: self.email, firstName: self.firstName, lastName: self.lastName, gender: self.gender, phone: self.phone, rate: self.rate, password: "hasełko")
    }
}

