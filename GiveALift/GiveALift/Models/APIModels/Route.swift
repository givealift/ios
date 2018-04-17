//
//  Route.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct Route: Codable {
    let ownerID: Int
    let from, to: Location
    let departureTime: String
    let numberOfSeats, numberOfOccupiedSeats: Int
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "ownerId"
        case from, to, departureTime, numberOfSeats, numberOfOccupiedSeats, price
    }
}

struct Location: Codable {
    let city: RouteCity
    let street: String
    let buildingNumber: Int
}

struct RouteCity: Codable {
    let cityID: Int
    
    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
    }
}
