//
//  LoginPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 22.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol LoginView: class {
    func showError(with message: String)
}

final class LoginPresenter: BasePresenter {
    
    private weak var connector: OnboardingConnectorDelegate?
    private let onboardingService = OnboardingService()
    weak var view: LoginView?

    let mailPlaceholder = "Twój email"
    let passwordPlaceholder = "Hasło"
    let wrongData = "Podane dane są niepoprawne"
    let resetPasswordMessage = "Podaj swój e-mail aby zresetować hasło"
    
    init(connector: OnboardingConnectorDelegate) {
        super.init()
        self.connector = connector
        onboardingService.loginDelegate = self
        onboardingService.passwordResetDelegate = self
    }
    
    func resetPassword(email: String) {
        onboardingService.resetPassword(email: email)
    }
    
    func tryToLogIn(email: String, password: String) {
        onboardingService.login(email: email, password: password)
    }
    
    func showRegisterView() {
        connector?.showRegisterView()
    }
}

extension LoginPresenter: OnboardingServiceLoginDelegate, PasswordResetDelegate {
    func passwordResetSuccess() {
        UIAlertController.showAlert(withMessage: "Na podany email został wysłany link do zrestowania hasła")
    }
    
    func onboardingService(error: APIError) {
        SVProgressHUD.dismiss()
        switch error {
        case .unexpectedError:
            view?.showError(with: error.description)
        default:
            view?.showError(with: wrongData)
        }
    }
    
    func onboardingService(user: GALUserLogin, userInfo: GALUserInfo) {
        User.shared.logIn(user: user, userInfo: userInfo)
        SVProgressHUD.dismiss()
        connector?.showHomeView()
    }
}


