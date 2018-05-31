//
//  UserInfoViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class UserInfoViewController: TextFieldViewController<UserInfoPresenter> {
    
    //MARK:- IBOutlets
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var birthdayTextField: GALTextField!
    @IBOutlet weak var firstNameTextField: GALTextField!
    @IBOutlet weak var secondNameTextField: GALTextField!
    @IBOutlet weak var compatibilePasswordTextField: GALTextField!
    @IBOutlet weak var gender: GALTextField!
    @IBOutlet weak var emailTextField: GALTextField!
    @IBOutlet weak var passwordTextField: GALTextField!
    @IBOutlet weak var phoneNumberTextField: GALTextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var textFields: [GALTextField]!
    @IBOutlet var regularButtons: [UIButton]!
    @IBOutlet var editButtons: [UIButton]!
    
    //MARK:- Variables
    private lazy var dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        editButton.isHidden = !presenter.editModeEnabled
    }

    //MARK:- IBActions
    @IBAction func dissmisTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        //MARK:- TODO naprawić ten śmietnik
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
        let result  = emailTextField.text!.validated(with: validationRule)
        let result1 = phoneNumberTextField.text!.validated(with: validationRule)
        switch result  {
        case .invalid(error: _):
            return
        case .valid:
            print("valid")
        }
        switch result1  {
        case .invalid(error: _):
            return
        case .valid:
            print("valid")
        }
        let name = firstNameTextField.text != "" ? User.shared.firstName : firstNameTextField.text!
        let lastName = secondNameTextField.text != "" ? User.shared.lastName : secondNameTextField.text!
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
        birthdayTextField.placeholder = dateFormatter.string(from: presenter.userData.birthYear!)
    }
    
    //MARK:- Main
    private func editState(_ value: Bool) {
        regularButtons.forEach({ $0.isHidden = value })
        editButtons.forEach({ $0.isHidden = !value })
        textFields.forEach({
            $0.isUserInteractionEnabled = value
            $0.text = nil
            $0.delegate = self
        })
    }
    
    private func setupTextFields() {
        firstNameTextField.text = presenter.userData.firstName
        secondNameTextField.text = presenter.userData.lastName
        emailTextField.text = presenter.userData.email
        phoneNumberTextField.text = presenter.userData.phone
        gender.text = presenter.userData.gender
        birthdayTextField.text = dateFormatter.string(from: presenter.userData.birthYear!)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.frame.origin.y )
        print((UIScreen.main.bounds.height / 2))
        if textField.frame.origin.y + 160.0 > (UIScreen.main.bounds.height / 2) {
            logoTopConstraint.constant = -(textField.frame.origin.y - 100.0)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutSubviews()
            }
        }
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
        logoTopConstraint.constant = 50
        UIView.animate(withDuration: 0.25) {
            self.view.layoutSubviews()
        }
    }
}
