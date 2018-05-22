//
//  OnboardingConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 22.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol OnboardingConnectorDelegate: class {
    func showHomeView()
}

final class OnboardingConnector {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showLoginView()
    }
    
    private func showLoginView() {
        let presenter = LoginPresenter(connector: self)
        let view = LoginViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}

extension OnboardingConnector: OnboardingConnectorDelegate {
    func showHomeView() {
        
    }
}
