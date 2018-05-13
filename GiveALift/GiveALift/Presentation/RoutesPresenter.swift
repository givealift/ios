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
    
    init(connector: SearchConnectorDelegate, routes: [Route]) {
        self.routes = routes
        self.connector = connector
    }
    
    func showRouteDetailsView(route: Route) {
        connector?.showRouteDetailsView(route: route)
    }
}
