//
//  RouteTimePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteTimePresenter: AddRoutePresenter {
    
    let datePlaceholder = "Data odjazdu"
    let timePlaceholder = " godzina odjazdu"
    let finishPlaceholder = " godzina przyjazdu"
    
    func showRouteInfoView(departureDate: String, departureTime: String, finishTime: String ,indirectDates: [String]) {
        updateModel(departureDate: departureDate, departureTime: departureTime, finishTime: finishTime, indirectDates: indirectDates)
        connector?.showRouteInfoView(route: route, isUpdating: false)
    }
    
    private func updateModel(departureDate: String, departureTime: String,finishTime: String ,indirectDates: [String]) {
        route.from.date = departureDate + " " + departureTime
        route.to.date = departureDate + " " + finishTime
        for i in 0 ..< indirectDates.count {
            route.stops[i].date = departureDate + indirectDates[i]
        }
    }
}
