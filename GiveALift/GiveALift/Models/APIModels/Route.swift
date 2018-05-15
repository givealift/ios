//
//  Route.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct Route: Codable {
    var routeId: Int!
    var from, to: Location!
    var stops: [Location]!
    var numberOfSeats, numberOfOccupiedSeats, price: Int!
    var description: String?
    var ownerId: Int?
    var galUserPublicResponse: GalUserPublicResponse?
}

struct GalUserPublicResponse: Codable {
    var ownerId: Int!
}

struct Location: Codable {
    var city: City!
    var placeOfMeeting: String!
    var date: String!
    var localizationId: Int?
}

struct City: Codable {
    var cityID: Int!
    var name, country, province: String?
    var cityInfo: CityInfo?
    
    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case name, country, province, cityInfo
    }
}

struct CityInfo: Codable {
    var cityInfoID, population, citySize: Int
    
    enum CodingKeys: String, CodingKey {
        case cityInfoID = "cityInfoId"
        case population, citySize
    }
}
