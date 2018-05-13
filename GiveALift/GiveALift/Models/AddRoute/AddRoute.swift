//
//  Location.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class AddRoute: Codable {
    var from: RouteLocation!
    var to: RouteLocation!
    var stops = [RouteLocation]()
    var price: Int!
    var numberOfSeats: Int!
    var numberOfOccupiedSeats = 2
//    var ownerId = User.shared.userID
    var ownerId = 1
    var routeId = 610
    var description: String?
}

final class RouteLocation: Codable {
    var city: AddRouteCity!
    var placeOfMeeting: String!
    var date: String!
}

final class AddRouteCity: Codable {
    var cityId: Int!
}


