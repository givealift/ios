//
//  LoginViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 26.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: GALTextField!
    @IBOutlet weak var emailTextField: GALTextField!
    
    weak var connector: RootConnectorDelegate?
    private let onboardingService = OnboardingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingService.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        
        guard validCredentials() else { return }
        onboardingService.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    private func validCredentials() -> Bool {
        if passwordTextField.text == nil || emailTextField.text == nil {
            return false
        }
        return true
    }
}

extension LoginViewController: OnboardingServiceDelegate {
    func onboardingService(error: APIError) {
        print(error)
    }
    
    func onboardingService(user: GALUserLogin, result: GALUserInfo) {
        print(result)
        User.shared.logIn(user: user, userInfo: result)
        print("user id \(user.userID)")
        self.connector?.showHomeView()
    }
    
    
}
