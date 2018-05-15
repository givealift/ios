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
    
    func showMainRouteView() {
        connector?.addRouteConnector?.showMainRouteView(route: route, isUpdating: true)
    }
    
    func showIndirectsView() {
        connector?.addRouteConnector?.showIndirectionsView(route: route, isUpdating: true)
    }
    
    func showRouteTimeView() {
        connector?.addRouteConnector?.showRouteTimeView(route: route, isUpdating: true)
    }
    
    func showRouteInfoView() {
        connector?.addRouteConnector?.showRouteInfoView(route: route, isUpdating: true)
    }
    
    func showOptionalDescriotionView() {
        connector?.addRouteConnector?.showRouteOptionalDescriptionView(route: route, isUpdating: true)
    }
}
