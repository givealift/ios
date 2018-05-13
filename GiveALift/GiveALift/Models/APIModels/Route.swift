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
    let stops: [Location]?
    let numberOfSeats, numberOfOccupiedSeats, price: Int
}

struct Location: Codable {
    let city: City
    let placeOfMeeting: String
    let date: String
    let localizationId: Int
}

struct RouteCity: Codable {
    let cityId: Int
    let name: String?
    let country: String?
    let province: String?
    let cityInfo: RouteCityInfo?
}

struct RouteCityInfo: Codable {
    let cityInfoId, population, citySize: Int
}
