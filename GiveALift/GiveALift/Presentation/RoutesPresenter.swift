//
//  RoutesPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RoutesPresenter: BasePresenter {
    
    private weak var connector: SearchConnectorDelegate?
    let routes: [Route]
    let fromCityID: Int?
    let toCityID: Int?
    
    init(connector: SearchConnectorDelegate, routes: [Route], fromCityID: Int?, toCityID: Int?) {
        self.routes = routes
        self.connector = connector
        self.fromCityID = fromCityID
        self.toCityID = toCityID
    }
    
    func showRouteDetailsView(route: Route) {
        connector?.showRouteDetailsView(route: route)
    }
}
