//
//  RouteTimePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteTimePresenter: BasePresenter {
    
    let datePlaceholder = "Wybierz datę odjazdu"
    let timePlaceholder = "Wybierz godzinę odjazdu"
    
    private weak var connector: AddRouteConnector?
    var route: Route
    
    init(connector: AddRouteConnector, route: Route) {
        self.connector = connector
        self.route = route
    }
    
    func showRouteInfoView(departureDate: String, departureTime: String ,indirectDates: [String]) {
        updateModel(departureDate: departureDate, departureTime: departureTime, indirectDates: indirectDates)
        connector?.showRouteInfoView(route: route)
    }
    
    private func updateModel(departureDate: String, departureTime: String, indirectDates: [String]) {
        route.from.date = departureDate + " " + departureTime
        route.to.date = "2018-05-08 23:15"
        for i in 0 ..< indirectDates.count {
            route.stops?[i].date = departureDate + indirectDates[i]
        }
    }
}
