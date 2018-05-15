//
//  AddRouteConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol AddRouteConnectorDelegate: class {
    func showRouteTimeView(route: Route, isUpdating: Bool)
    func showIndirectionsView(route: Route, isUpdating: Bool)
    func showRouteInfoView(route: Route, isUpdating: Bool)
    func showRouteOptionalDescriptionView(route: Route, isUpdating: Bool)
    func showHomeView()
    func showAddRouteView(route: Route, isUpdating: Bool)
    func showPreviuosView()
}

final class AddRouteConnector {
    
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension AddRouteConnector: AddRouteConnectorDelegate {
    func showPreviuosView() {
        navigationController.popViewController(animated: true)
    }
    
    func showAddRouteView(route: Route, isUpdating: Bool) {
        let presenter = MainRoutePresenter(connector: self, route: route, isUpdating: isUpdating)
        let view = MainRouteViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showHomeView() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showRouteOptionalDescriptionView(route: Route, isUpdating: Bool) {
        let presenter = RouteOptionalDescriptionPresenter(connector: self, route: route, isUpdating: isUpdating)
        let view = RouteOptionalDescriptionViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showIndirectionsView(route: Route, isUpdating: Bool) {
        let presenter = IndirectionsPresenter(connector: self, route: route, isUpdating: isUpdating)
        let view = IndirectionsViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteTimeView(route: Route, isUpdating: Bool) {
        let presenter = RouteTimePresenter(connector: self, route: route, isUpdating: isUpdating)
        let view = RouteTimeViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteInfoView(route: Route, isUpdating: Bool) {
        let presenter = RouteInfoPresenter(connector: self, route: route, isUpdating: isUpdating)
        let view = RouteInfoViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}
