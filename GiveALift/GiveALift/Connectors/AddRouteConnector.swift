//
//  AddRouteConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol AddRouteConnectorDelegate: class {
    func showRouteTimeView(route: Route)
    func showIndirectionsView(route: Route)
    func showRouteInfoView(route: Route)
    func showRouteOptionalDescriptionView(route: Route)
    func showHomeView()
}

final class AddRouteConnector {
    
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showAddRouteView()
    }
    
    private func showAddRouteView() {
        let presenter = AddRoutePresenter(connector: self)
        let view = AddRouteViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    deinit {
        print("tersaz")
    }
}

extension AddRouteConnector: AddRouteConnectorDelegate {
    func showHomeView() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showRouteOptionalDescriptionView(route: Route) {
        let presenter = RouteOptionalDescriptionPresenter(connector: self, route: route)
        let view = RouteOptionalDescriptionViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showIndirectionsView(route: Route) {
        let presenter = IndirectionsPresenter(connector: self, route: route)
        let view = IndirectionsViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteTimeView(route: Route) {
        let presenter = RouteTimePresenter(connector: self, route: route)
        let view = RouteTimeViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteInfoView(route: Route) {
        let presenter = RouteInfoPresenter(connector: self, route: route)
        let view = RouteInfoViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}
