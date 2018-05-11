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
        guard let preLoginRegisterVC = Storyboards.Onboarding.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Can't load loginVC")
        }
        //MARK:- TOOD login view
        //window.rootViewController = preLoginRegisterVC
    }
    
    private func presentHomeVC() {
        connector?.showHomeView()
    }
}
