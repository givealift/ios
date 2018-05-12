//
//  RouteOptionalDescription.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteOptionalDescriptionPresenter: BasePresenter {
    
    private let addRoute: AddRoute
    private weak var connector: AddRouteConnectorDelegate?
    
    init(connector: AddRouteConnectorDelegate, addRoute: AddRoute) {
        self.addRoute = addRoute
        self.connector = connector
    }
}
