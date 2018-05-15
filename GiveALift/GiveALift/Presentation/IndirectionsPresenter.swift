//
//  IndirectionsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class IndirectionsPresenter: BasePresenter {
    
    private var route: Route
    private weak var connector: AddRouteConnectorDelegate?
    
    let indirectTextFieldPlaceHolder = "Wprowadź miasto pośrednie"
    let indirectLocationPlaceholder = "Wprowadź miejsce odbioru"
    
    init(connector: AddRouteConnectorDelegate, route: Route) {
        self.route = route
        self.connector = connector
    }
    
    func showRouteTimeView(indirectCitys: [Int], indirectLocations: [String]) {
        updateModel(indirectCitys: indirectCitys, indirectLocations: indirectLocations)
        connector?.showRouteTimeView(route: route)
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
}
