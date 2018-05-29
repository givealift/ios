//
//  RegistrationPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 29.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol RegisterView: class {
    func showError(with message: String)
}

final class RegistrationPresenter: BasePresenter {
    
    private weak var connector: OnboardingConnectorDelegate?
    private let onboardingService = OnboardingService()
    weak var view: RegisterView?
    
    let textFieldsData: [RegisterCellType] = [NameCell(), SurnameCell(), EmailCell(), PasswordCell(), CompatibilePasswordCell(), BirthdayCell(), PhoneNumberCell()]
    
    
    init(connector: OnboardingConnectorDelegate) {
        super.init()
        self.connector = connector
    }
}
