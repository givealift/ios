//
//  HomePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class HomePresenter: BasePresenter {
    
    private weak var connectorDelegate: HomeConnectorDelegate?
    
    init(connectorDelegate: HomeConnectorDelegate) {
        self.connectorDelegate = connectorDelegate
    }
    
    func showSearchView() {
        connectorDelegate?.showSearchView()
    }
}
