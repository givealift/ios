//
//  HomePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class HomePresenter: BasePresenter {
    
    private weak var connectorDelegate: RootConnectorDelegate?
    
    init(connectorDelegate: RootConnectorDelegate) {
        self.connectorDelegate = connectorDelegate
    }
    
    func showSearchView() {
        connectorDelegate?.showSearchView()
    }
    
    func showAddRouteView() {
        connectorDelegate?.showAddRouteView()
    }
    
    func showUserInfoView() {
        connectorDelegate?.showUserInfoView(userData: prepareUserInfo())
    }
    
    private func prepareUserInfo() -> GALUserInfo {
        return GALUserInfo(address: "", birthYear: 19, email: User.shared.email!, firstName: User.shared.firstName!, gender: User.shared.gender!, lastName: User.shared.lastName!, phone: User.shared.phoneNumber!, rate: 0)
    }
}
