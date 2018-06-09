//
//  RegistrationPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 29.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation
import SVProgressHUD

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
        onboardingService.registerDelegate = self
        setObserverForPasswordCell()
    }
    
    func register(name: String, lastname: String, mail: String, password: String, brithday: Date, phone: String) {
        onboardingService.register(request: RegisterRequest(address: "", birthYear: brithday, email: mail, firstName: name, gender: "", lastName: lastname, password: password, phone: phone, rate: 0))
    }
    
    func showLoginView() {
        connector?.goBackToLoginView()
    }
    
    private func setObserverForPasswordCell() {
        let passwordCell = textFieldsData[3] as! PasswordCell
        let compatibileCell = textFieldsData[4] as! CompatibilePasswordCell
        compatibileCell.passwordCell = passwordCell
    }
}

extension RegistrationPresenter: OnboardingServiceRegisterDelegate {
    func onboardingService(status: Bool) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showSuccess(withStatus: "Powodzenie")
        showLoginView()
    }
    
    func onboardingService(error: APIError) {
        view?.showError(with: error.description)
    }
}
