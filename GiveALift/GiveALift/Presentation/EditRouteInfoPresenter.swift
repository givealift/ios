//
//  EditRouteInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class EditRouteInfoPresenter: BasePresenter {
    
    private weak var connector: SearchConnectorDelegate?
    private let route: Route
    
    init(connector: SearchConnectorDelegate, route: Route) {
        self.connector = connector
        self.route = route
    }
    
    func showAddRouteView() {
        connector?.addRouteConnector?.showAddRouteView(route: route, isUpdating: true)
    }
}
