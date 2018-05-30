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
    func showRegisterView()
    func goBackToLoginView()
}

final class OnboardingConnector {
    
    private let navigationController: UINavigationController
    weak var rootConnector: RootConnectorDelegate?
    
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
    func goBackToLoginView() {
        navigationController.popViewController(animated: true)
    }
    
    func showRegisterView() {
        let presenter = RegistrationPresenter(connector: self)
        let view = RegistrationViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
    
    func showHomeView() {
        rootConnector?.endOnboardingConnector()
    }
}
