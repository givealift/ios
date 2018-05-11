//
//  Route.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

struct Route: Codable {
    let routeId, ownerId: Int
    let from, to: Location
    let departureTime: String
    let numberOfSeats, numberOfOccupiedSeats, price: Int
}

struct Location: Codable {
    let localizationId: Int
    let city: City
    let street: String
    let buildingNumber: Int
}

struct RouteCity: Codable {
    let cityId: Int
    let name, country, province: String
    let cityInfo: RouteCityInfo
}

struct RouteCityInfo: Codable {
    let cityInfoId, population, citySize: Int
}
