//
//  AddRouteConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol AddRouteConnectorDelegate: class {
    func showRouteTimeView()
    func showRouteInfoView()
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
    
    func showRouteTimeView() {
        let presenter = RouteTimePresenter(connector: self)
        let view = RouteTimeViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteInfoView() {
        let presenter = RouteInfoPresenter(connector: self)
        let view = RouteInfoViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}
