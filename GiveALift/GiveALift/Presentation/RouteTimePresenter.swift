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
    let addRoute: AddRoute
    
    init(connector: AddRouteConnector, addRoute: AddRoute) {
        self.connector = connector
        self.addRoute = addRoute
    }
    
    func showRouteInfoView(departureDate: String, departureTime: String ,indirectDates: [String]) {
        updateModel(departureDate: departureDate, departureTime: departureTime, indirectDates: indirectDates)
        connector?.showRouteInfoView(addRoute: addRoute)
    }
    
    private func updateModel(departureDate: String, departureTime: String, indirectDates: [String]) {
        addRoute.from.date = departureDate + departureTime
        for i in 0 ..< indirectDates.count {
            addRoute.stops[i].date = departureDate + indirectDates[i]
        }
    }
}
