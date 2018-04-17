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
        if isLogIn() {
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
        window.rootViewController = preLoginRegisterVC
    }
    
    private func presentHomeVC() {
//        guard let homeVC = Storyboards.Main.instantiateInitialViewController() as? UINavigationController else {
//            fatalError("Can't load homeVc")
//        }
        let presenter = HomePresenter()
        let homeVC = HomeViewController(presenter: presenter)
        let nav = UINavigationController()
        window.rootViewController = nav
        nav.pushViewController(homeVC, animated: true)
    }
}
