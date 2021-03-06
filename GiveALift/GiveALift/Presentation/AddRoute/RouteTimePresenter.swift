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
    
    func showEditRouteInfoView(departureDate: String?, departureTime: String?, finishTime: String? ,indirectDates: [String?]) {
        updateOLDModel(departureDate: departureDate, departureTime: departureTime, finishTime: finishTime ,indirectDates: indirectDates)
        connector?.showPreviuosView()
    }
    
    private func updateModel(departureDate: String, departureTime: String,finishTime: String ,indirectDates: [String]) {
        route.from.date = departureDate + " " + departureTime
        route.to.date = departureDate + " " + finishTime
        for i in 0 ..< indirectDates.count {
            route.stops[i].date = departureDate + " " + indirectDates[i]
        }
    }
    
    private func updateOLDModel(departureDate: String?, departureTime: String?,finishTime: String? ,indirectDates: [String?]) {
        if departureDate == nil {
            route.from.date = departureTime == nil ? route.from.date : route.from.date.extractDateString() + " " + departureTime!
            route.to.date = finishTime == nil ? route.to.date : route.to.date.extractDateString() + " " + finishTime!
            for i in 0 ..< indirectDates.count {
                if let date = indirectDates[i] {
                    route.stops[i].date = route.from.date.extractDateString() + " " + date
                }
            }
        } else {
            route.from.date = departureTime == nil ? departureDate! + " " + route.from.date.extractHourString() : departureDate! + " " + departureTime!
            route.to.date = finishTime == nil ? finishTime! + " " + route.to.date.extractHourString() : departureDate! + " " + finishTime!
            for i in 0 ..< indirectDates.count {
                if let date = indirectDates[i] {
                    route.stops[i].date = departureDate! + " " + date
                }
            }
        }
    }
}
