//
//  SearchConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol SearchConnectorDelegate: class {
    func showRoutesView(routes: [Route])
    func showRouteDetailsView(route: Route)
}

final class SearchConnector {
    
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showSearchView()
    }
    
    private func showSearchView() {
        let presenter = SearchPresenter(connector: self)
        let view = SearchViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}

extension SearchConnector: SearchConnectorDelegate {
    func showRoutesView(routes: [Route]) {
        let presenter = RoutesPresenter(connector: self, routes: routes)
        let view = RoutesViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteDetailsView(route: Route) {
        let presenter = RouteDetailsPresenter(connector: self, route: route)
        let view = RouteDetailsViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}
