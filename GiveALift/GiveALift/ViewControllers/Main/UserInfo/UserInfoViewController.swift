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
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var textFields: [GALTextField]!
    @IBOutlet var regularButtons: [UIButton]!
    @IBOutlet var editButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupTextFields()
        editButton.isHidden = !presenter.editModeEnabled
    }

    @IBAction func dissmisTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        var validationRule: ValidatorRule {
            var rule = ValidatorRulePattern(pattern: .email)
            rule.set(errorMessage: "Podany emial jest niewłaciwy")
            return rule
        }
        var validationRule1: ValidatorRule {
            var rule = ValidatorRulePattern(pattern: .phoneNumber)
            rule.set(errorMessage: "Podany numer jest nieporawny")
            return rule
        }
        
    }
    
    @IBAction func cancleTapped(_ sender: Any) {
        editState(false)
        setupTextFields()
    }
    
    @IBAction func editTapped(_ sender: Any) {
        editState(true)
        firstNameTextField.placeholder = presenter.userData.firstName
        secondNameTextField.placeholder = presenter.userData.lastName
        emailTextField.placeholder = presenter.userData.email
        phoneNumberTextField.placeholder = presenter.userData.phone
        gender.placeholder = presenter.userData.gender
    }
    
    private func editState(_ value: Bool) {
        regularButtons.forEach({ $0.isHidden = value })
        editButtons.forEach({ $0.isHidden = !value })
        textFields.forEach({
            $0.isUserInteractionEnabled = value
            $0.text = nil
        })
    }
    
    private func setupTextFields() {
        firstNameTextField.text = presenter.userData.firstName
        secondNameTextField.text = presenter.userData.lastName
        emailTextField.text = presenter.userData.email
        phoneNumberTextField.text = presenter.userData.phone
        gender.text = presenter.userData.gender
    }
}
