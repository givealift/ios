//
//  IndirectionsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class IndirectionsPresenter: AddRoutePresenter {
    
    //MARK:- TODO usuwanie przystanków i ograniczenie ich liczby, przesuwanie też
    
    let indirectTextFieldPlaceHolder = "Wprowadź miasto pośrednie"
    let indirectLocationPlaceholder = "Wprowadź miejsce odbioru"
    
    func showEditRouteInfo(indirects: [Indirect]) {
        updateOldModel(indirects: indirects)
        connector?.showPreviuosView()
    }
    
    func showRouteTimeView(indirectCitys: [Int], indirectLocations: [String]) {
        updateModel(indirectCitys: indirectCitys, indirectLocations: indirectLocations)
        print(route)
        connector?.showRouteTimeView(route: route, isUpdating: false)
    }
    
    private func updateModel(indirectCitys: [Int], indirectLocations: [String]) {
        route.stops = []
        for i in 0..<indirectCitys.count {
            var routeLocation = Location()
            routeLocation.city = City()
            routeLocation.city.cityID = indirectCitys[i]
            routeLocation.placeOfMeeting = indirectLocations[i]
            route.stops?.append(routeLocation)
        }
        
    }
    
    private func updateOldModel(indirects: [Indirect]) {
        for i in 0 ..< indirects.count {
            if route.stops[i].city.cityID == indirects[i].cityID {
                
            } else {
                route.stops[i] = indirects[i].toLocation()
            }
        }
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
