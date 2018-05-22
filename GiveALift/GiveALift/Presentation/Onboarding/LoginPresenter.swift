//
//  LoginPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 22.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class LoginPresenter: BasePresenter {
    
    private weak var connector: OnboardingConnectorDelegate?
    
    let mailPlaceholder = "Twój email"
    let passwordPlaceholder = "Hasło"
    
    init(connector: OnboardingConnectorDelegate) {
        self.connector = connector
    }
}
