//
//  RouteOptionalDescription.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteOptionalDescriptionPresenter: AddRoutePresenter {
    
    func showHomeView(description: String?) {
        updateModel(description: description)
        addRouteToServer()
        connector?.showHomeView()
    }
    
    private func updateModel(description: String?) {
        route.description = description
    }
    
    private func addRouteToServer() {
        var stop1 = Location()
        stop1.city = City()
        stop1.city.cityID = 405
        stop1.placeOfMeeting = "siusiaczek"
        stop1.date = "2018-05-08 22:45"
        var stop2 = Location()
        stop2.city = City()
        stop2.city.cityID = 407
        stop2.placeOfMeeting = "siusiaczek"
        stop2.date = "2018-05-08 22:55"
        route.stops?.append(stop2)
        route.stops?.append(stop1)
        APIManager.shared.addRoute(route: route)
    }
}
