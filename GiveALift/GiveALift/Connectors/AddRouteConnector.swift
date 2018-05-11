//
//  AddRouteConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol AddRouteConnectorDelegate {
    
}

final class AddRouteConnector {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showAddRouteView()
    }
    
    private func showAddRouteView() {
        let presenter = AddRoutePresenter(connector: self)
        let view = AddRouteViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}
