//
//  LoginViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 26.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    weak var connector: RootConnectorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard validCredentials() else { return }
        APIManager.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                print(error)
            case .Success(result: let result):
                User.shared.logIn(user: result)
                print(User.shared.userID)
                //let _ = HomeConnector(navigationController: self.navigationController!)
                self?.connector?.showHomeView()
            }
        }
    }
    
    private func validCredentials() -> Bool {
        if passwordTextField.text == nil || emailTextField.text == nil {
            return false
        }
        return true
    }
}
