//
//  SearchConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol SearchConnectorDelegate: class {
    func showRoutesView(routes: [Route], fromCityID: Int?, toCityID: Int?)
    func showRouteDetailsView(route: Route)
    func startAddRouteConnector()
    func endAddRouteConnector()
    func startOnboardingConnector()
    func startUserInfoConnector(userInfo: GALUserInfo, editModeEnabled: Bool)
    var  addRouteConnector: AddRouteConnectorDelegate? { get set }
    var userInfoConnector: UserInfoConnectorDelegate? { get set }
    var rootConnector: RootConnectorDelegate? { get set }
}

final class SearchConnector {
    
    private unowned let navigationController: UINavigationController
    var addRouteConnector: AddRouteConnectorDelegate?
    var userInfoConnector: UserInfoConnectorDelegate?
    var rootConnector: RootConnectorDelegate?
    
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
    func startOnboardingConnector() {
        rootConnector?.endSearchConnector()
    }
    
    func startUserInfoConnector(userInfo: GALUserInfo, editModeEnabled: Bool) {
        self.userInfoConnector = UserInfoConnector(navigationController: self.navigationController)
        userInfoConnector?.searchConnector = self
        userInfoConnector?.showUserInfoView(userData: userInfo, editModeEnabled: editModeEnabled)
    }
    
    func endAddRouteConnector() {
        addRouteConnector = nil
        showHomeView()
    }
    
    func startAddRouteConnector() {
        self.addRouteConnector = AddRouteConnector(navigationController: self.navigationController)
        addRouteConnector?.searchConnector = self
        addRouteConnector?.showMainRouteView(route: Route(), isUpdating: false)
    }
    
    func showRoutesView(routes: [Route], fromCityID: Int?, toCityID: Int?) {
        let presenter = RoutesPresenter(connector: self, routes: routes, fromCityID: fromCityID, toCityID: toCityID)
        let view = RoutesViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
    
    func showRouteDetailsView(route: Route) {
        let presenter = RouteDetailsPresenter(connector: self, route: route)
        let view = RouteDetailsViewController(presenter: presenter)
        navigationController.pushViewController(view, animated: true)
    }
}
