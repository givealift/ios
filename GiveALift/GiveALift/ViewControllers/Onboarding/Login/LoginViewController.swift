//
//  LoginViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 22.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class LoginViewController: TextFieldViewController<LoginPresenter> {

    //MARK:- IBOutlets
    @IBOutlet weak var mailTextField: GALTextField!
    @IBOutlet weak var passwordTextField: GALTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupRegisterButton()
    }
    
    //MARK:- IBActions
    @IBAction func registerTapped(_ sender: Any) {
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = mailTextField.text, let password = passwordTextField.text, email != "", password != "" {
            presenter.tryToLogIn(email: email, password: password)
        } else {
            showError(with: presenter.wrongData)
        }
    }
    
    //MARK:- Main
    private func setupTextFields() {
        mailTextField.tag = 1
        passwordTextField.tag = 2
        mailTextField.placeholder = presenter.mailPlaceholder
        passwordTextField.placeholder = presenter.passwordPlaceholder
        mailTextField.keyboardType = .emailAddress
        passwordTextField.delegate = self
        mailTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupRegisterButton() {
        registerButton.tintColor = UIColor.GALBlue
    }
}

extension LoginViewController: LoginView {
    
}

