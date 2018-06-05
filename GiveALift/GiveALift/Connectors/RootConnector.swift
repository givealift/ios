//
//  RootConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol RootConnectorDelegate: class {
    func startOnboardingConnector()
    func endOnboardingConnector()
    func startSearchConnector()
    func endSearchConnector()
}

final class RootConnector {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    private var searchConnector: SearchConnectorDelegate?
    private var addRouteConnector: AddRouteConnectorDelegate?
    private var userInfoConnector: UserInfoConnectorDelegate?
    private var onboardingConnector: OnboardingConnectorDelegate?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        setupNavigationController()
        self.window.backgroundColor = .white
        self.window.rootViewController = navigationController
    }
    
    private func setupNavigationController() {
        self.navigationController.navigationBar.barTintColor = UIColor.GALBlue
        self.navigationController.navigationBar.isTranslucent = false
        self.navigationController.navigationBar.tintColor = UIColor.white
    }
}

extension RootConnector: RootConnectorDelegate {
    func endSearchConnector() {
        self.searchConnector = nil
        startOnboardingConnector()
    }
    
    func startSearchConnector() {
        self.searchConnector = SearchConnector(navigationController: self.navigationController)
        searchConnector?.rootConnector = self
    }
    
    func startOnboardingConnector() {
        let onboardingConnector = OnboardingConnector(navigationController: self.navigationController)
        onboardingConnector.rootConnector = self
        self.onboardingConnector = onboardingConnector
    }
    
    func endOnboardingConnector() {
        self.onboardingConnector = nil
        startSearchConnector()
    }
    
    func showUserInfoView(userData: GALUserInfo) {
        self.userInfoConnector = UserInfoConnector(navigationController: self.navigationController)
        userInfoConnector?.showUserInfoView(userData: userData, editModeEnabled: true)
    }
    
    func showAddRouteView() {
        self.addRouteConnector = AddRouteConnector(navigationController: self.navigationController)
        addRouteConnector?.showMainRouteView(route: Route(), isUpdating: false)
    }
}
