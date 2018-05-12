//
//  Location.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class AddRoute {
    var from: RouteLocation!
    var to: RouteLocation!
    var indirections = [RouteLocation]()
}

final class RouteLocation {
    var cityId: Int!
    var location: String!
    var departureTime: String!
}
