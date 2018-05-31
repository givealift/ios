//
//  SearchConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol SearchConnectorDelegate: class {
    func showRoutesView(routes: [Route], fromCityID: Int, toCityID: Int)
    func showRouteDetailsView(route: CellRouteData)
    func showUserInfoView(userData: GALUserInfo)
    func showEditRouteInfoView(route: Route)
    var  addRouteConnector: AddRouteConnectorDelegate? { get set }
}

final class SearchConnector {
    
    private unowned let navigationController: UINavigationController
    var addRouteConnector: AddRouteConnectorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showHomeView()
    }
    
    private func showHomeView() {
        let presenter = HomePresenter(connector: self)
        let view = HomeViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}

extension SearchConnector: SearchConnectorDelegate {
    func showEditRouteInfoView(route: Route) {
        let presenter = EditRouteInfoPresenter(connector: self, route: route)
        let view = EditRouteInfoViewController(presenter: presenter)
        self.addRouteConnector = AddRouteConnector(navigationController: self.navigationController)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRoutesView(routes: [Route], fromCityID: Int, toCityID: Int) {
        let presenter = RoutesPresenter(connector: self, routes: routes, fromCityID: fromCityID, toCityID: toCityID)
        let view = RoutesViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteDetailsView(route: CellRouteData) {
        let presenter = RouteDetailsPresenter(connector: self, route: route)
        let view = RouteDetailsViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showUserInfoView(userData: GALUserInfo) {
        let connector = UserInfoConnector(navigationController: self.navigationController)
        connector.showUserInfoView(userData: userData, editModeEnabled: false)
    }
}
