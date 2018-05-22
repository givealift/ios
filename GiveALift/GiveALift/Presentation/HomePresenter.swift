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
        //connectorDelegate?.showSearchView()
    }
    
    func showAddRouteView() {
      //  connectorDelegate?.showAddRouteView()
    }
    
    func showUserInfoView() {
        //connectorDelegate?.showUserInfoView(userData: prepareUserInfo())
    }
    
    private func prepareUserInfo() -> GALUserInfo {
        return GALUserInfo(address: "", birthYear: Date(), email: User.shared.email!, firstName: User.shared.firstName!, lastName: User.shared.lastName!, gender: "male", phone: User.shared.phoneNumber!, rate: 0)
    }
}
