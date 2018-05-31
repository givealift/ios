//
//  HomePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class HomePresenter: BasePresenter {
    
    private weak var connector: SearchConnectorDelegate?
    
    let fromPlaceholder = "Wyruszam z..."
    let toPlaceholder = "Jadę do..."
    let datePlaceholder = "Kiedy?"
    
    init(connector: SearchConnectorDelegate) {
        self.connector = connector
    }
    
    func showRoutesView(from: Int, to: Int, date: String) {
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
