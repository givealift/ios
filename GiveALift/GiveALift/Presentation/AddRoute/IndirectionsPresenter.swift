//
//  IndirectionsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class IndirectionsPresenter: AddRoutePresenter {
    
    let indirectTextFieldPlaceHolder = "Wprowadź miasto pośrednie"
    let indirectLocationPlaceholder = "Wprowadź miejsce odbioru"
    
    func showEditRouteInfo(indirects: [Indirect]) {
        updateOldModel(indirects: indirects)
        connector?.showPreviuosView()
    }
    
    func showRouteTimeView(indirectCitys: [Int], indirectLocations: [String]) {
        updateModel(indirectCitys: indirectCitys, indirectLocations: indirectLocations)
        connector?.showRouteTimeView(route: route, isUpdating: false)
    }
    
    private func updateModel(indirectCitys: [Int], indirectLocations: [String]) {
        for i in 0..<indirectCitys.count {
            var route = Route()
            var routeLocation = Location()
            routeLocation.city = City()
            routeLocation.city.cityID = indirectCitys[i]
            routeLocation.placeOfMeeting = indirectLocations[i]
            route.stops?.append(routeLocation)
        }
    }
    
    private func updateOldModel(indirects: [Indirect]) {
        route.stops = indirects.map({ $0.toLocation() })
    }
}

struct Indirect {
    let cityID: Int
    let location: String
    
    func toLocation() -> Location {
        var location = Location()
        location.city = City()
        location.city.cityID = self.cityID
        location.placeOfMeeting = self.location
        return location
    }
}
