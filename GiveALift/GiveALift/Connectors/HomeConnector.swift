//
//  HomeViewConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 04.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol HomeConnectorDelegate: class {
    func showSearchView()
}

final class HomeConnector {
    
    //MARK:- Constants
    private let navigationController: UINavigationController
    
    //MARK:- Connector's life cycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showHomeView()
    }
    
    //MARK:- Main
   private func showHomeView() {
        let presenter = HomePresenter(connectorDelegate: self)
        let homeVC = HomeViewController(presenter: presenter)
        navigationController.pushViewController(homeVC, animated: true)
    }
}

extension HomeConnector: HomeConnectorDelegate {
    func showSearchView() {
//        let presenter = SearchPresenter(
    }
}
