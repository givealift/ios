//
//  AddRouteConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol AddRouteConnectorDelegate: class {
    func showRouteTimeView(addRoute: AddRoute)
    func showIndirectionsView(addRoute: AddRoute)
    func showRouteInfoView(addRoute: AddRoute)
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
    
    func showIndirectionsView(addRoute: AddRoute) {
        let presenter = IndirectionsPresenter(connector: self, addRoute: addRoute)
        let view = IndirectionsViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    
    func showRouteTimeView(addRoute: AddRoute) {
        let presenter = RouteTimePresenter(connector: self, addRoute: addRoute)
        let view = RouteTimeViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteInfoView(addRoute: AddRoute) {
        let presenter = RouteInfoPresenter(connector: self, addRoute: addRoute)
        let view = RouteInfoViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}
