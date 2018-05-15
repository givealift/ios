//
//  AddRoutePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

class AddRoutePresenter: BasePresenter {
    
    weak var connector: AddRouteConnectorDelegate?
    var route: Route
    var isUpdating: Bool
    
    init(connector: AddRouteConnectorDelegate, route: Route, isUpdating: Bool) {
        self.connector = connector
        self.route = route
        self.isUpdating = isUpdating
    }
}
