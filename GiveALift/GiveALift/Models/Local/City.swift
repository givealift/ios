//
//  City.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct City: Codable {
    let cityID: Int
    let name, country, province: String
    let cityInfo: CityInfo
    
    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case name, country, province, cityInfo
    }
}

struct CityInfo: Codable {
    let cityInfoID, population, citySize: Int
    
    enum CodingKeys: String, CodingKey {
        case cityInfoID = "cityInfoId"
        case population, citySize
    }
}
