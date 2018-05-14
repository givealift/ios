//
//  UserInfoViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class UserInfoViewController: BaseViewController<UserInfoPresenter> {
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var compatibilePasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        setupTextFields()
    }

    @IBAction func dissmisTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        
    }
    
    private func setupTextFields() {
        firstNameTextField.text = User.shared.firstName
        secondNameTextField.text = User.shared.lastName
        emailTextField.text = User.shared.email
        phoneNumberTextField.text = User.shared.phoneNumber
    }
}
