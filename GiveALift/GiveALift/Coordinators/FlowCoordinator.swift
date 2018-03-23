//
//  FlowCoordinator.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 23.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class FlowCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if isLoggedIn() {
            presentHomeVC()
        } else {
            presentLoginVC()
        }
    }
    
    private func isLoggedIn() -> Bool {
        return false
    }
    
    private func presentLoginVC() {
        guard let loginVC = Storyboards.Onboarding.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Can't load loginVC")
        }
        window.rootViewController = loginVC
    }
    
    private func presentHomeVC() {
        guard let homeVC = Storyboards.Main.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Can't load homeVc")
        }
        window.rootViewController = homeVC
    }
}
