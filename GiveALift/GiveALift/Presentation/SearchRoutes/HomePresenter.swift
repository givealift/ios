//
//  HomePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func showError(with message: String)
}

final class HomePresenter: BasePresenter {
    
    private weak var connector: SearchConnectorDelegate?
    private let routesService = RoutesService()
    private var from: Int!
    private var to: Int!
    weak var view: HomeView?
    
    let fromPlaceholder = "Wyruszam z..."
    let toPlaceholder = "Jadę do..."
    let datePlaceholder = "Kiedy?"
    let emptyData = "Wpisz poprawne dane"
    
    init(connector: SearchConnectorDelegate) {
        super.init()
        self.connector = connector
        setDelegate()
    }
    
    private func setDelegate() {
        routesService.searchDelegate = self
    }
    
    func showRoutesView(from: Int, to: Int, date: String) {
        self.from = from
        self.to = to
        routesService.findRoutes(from: from, to: to, date: date)
    }
    
    func showAddRouteView() {
      connector?.startAddRouteConnector()
    }
    
    func showUserInfoView() {
        let user = GALUserInfo(address: "", birthYear: User.shared.birthDay, email: User.shared.email, firstName: User.shared.firstName, lastName: User.shared.lastName, gender: User.shared.gender, phone: User.shared.phoneNumber, rate: User.shared.rate, password: "hasełko")
        connector?.startUserInfoConnector(userInfo: user, editModeEnabled: true)
    }
    
    private func prepareUserInfo() -> GALUserInfo {
        return GALUserInfo(address: "", birthYear: Date(), email: User.shared.email!, firstName: User.shared.firstName!, lastName: User.shared.lastName!, gender: "male", phone: User.shared.phoneNumber!, rate: 0, password: "hasełko")
    }
}

extension HomePresenter: SearchRouteService {
    func foundRoutes(_ routes: [Route]) {
        connector?.showRoutesView(routes: routes, fromCityID: from, toCityID: to)
    }
    
    func serviceError(_ error: APIError) {
        view?.showError(with: error.description)
    }
}
