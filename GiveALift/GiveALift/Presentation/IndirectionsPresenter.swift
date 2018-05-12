//
//  IndirectionsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class IndirectionsPresenter: BasePresenter {
    
    private let addRoute: AddRoute
    private weak var connector: AddRouteConnectorDelegate?
    
    let indirectTextFieldPlaceHolder = "Wprowadź miasto pośrednie"
    let indirectLocationPlaceholder = "Wprowadź miejsce odbioru"
    
    init(connector: AddRouteConnectorDelegate, addRoute: AddRoute) {
        self.addRoute = addRoute
        self.connector = connector
    }
    
    func showRouteTimeView(indirectCitys: [Int], indirectLocations: [String]) {
        updateModel(indirectCitys: indirectCitys, indirectLocations: indirectLocations)
        connector?.showRouteTimeView(addRoute: addRoute)
    }
    
    private func updateModel(indirectCitys: [Int], indirectLocations: [String]) {
        for i in 0..<indirectCitys.count {
            let routeLocation = RouteLocation()
            routeLocation.city.cityId = indirectCitys[i]
            routeLocation.placeOfMeeting = indirectLocations[i]
            addRoute.stops.append(routeLocation)
        }
    }
}
