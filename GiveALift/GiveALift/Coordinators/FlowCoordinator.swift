//
//  FlowCoordinator.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 23.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class FlowCoordinator {
    
    private weak var connector: RootConnectorDelegate?
    
    init(connector: RootConnectorDelegate) {
        self.connector = connector
    }
    
    func start() {
        if User.shared.token != nil {
            presentHomeVC()
        } else {
            presentPreLoginRegisterVC()
        }
    }
    
    func isLogIn() -> Bool {
        return true
    }
    
    private func presentPreLoginRegisterVC() {
        connector?.startOnboardingConnector()
    }
    
    private func presentHomeVC() {
        connector?.showHomeView()
    }
}
