//
//  RootConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol RootConnectorDelegate: class {
    func showAddRouteView()
    func showSearchView()
    func showHomeView()
    func showPreLoginView()
}

final class RootConnector {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    private var searchConnector: SearchConnectorDelegate?
    private var addRouteConnector: AddRouteConnectorDelegate?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        setupNavigationController()
        self.window.backgroundColor = .white
        self.window.rootViewController = navigationController
    }
    
    private func setupNavigationController() {
        self.navigationController.navigationBar.barTintColor = UIColor.GALBlue
        self.navigationController.navigationBar.isTranslucent = false
        self.navigationController.navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
}

extension RootConnector: RootConnectorDelegate {
    func showPreLoginView() {
        let mainStoryboard = UIStoryboard(name: "Onboarding", bundle: Bundle.main)
        let vc : PreLoginRegisterViewController = mainStoryboard.instantiateViewController(withIdentifier: "PreLoginRegisterViewController") as! PreLoginRegisterViewController
        vc.connector = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showHomeView() {
        let presenter = HomePresenter(connectorDelegate: self)
        let homeVC = HomeViewController(presenter: presenter)
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func showAddRouteView() {
        self.addRouteConnector = AddRouteConnector(navigationController: self.navigationController)
    }
    
    func showSearchView() {
        self.searchConnector = SearchConnector(navigationController: self.navigationController)
    }
}
