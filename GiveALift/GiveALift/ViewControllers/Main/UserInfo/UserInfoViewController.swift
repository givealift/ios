//
//  UserInfoViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserInfoViewController: TextFieldViewController<UserInfoPresenter>, UserInfoView {
    
    //MARK:- IBOutlets
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var birthdayTextField: GALTextField!
    @IBOutlet weak var firstNameTextField: GALTextField!
    @IBOutlet weak var secondNameTextField: GALTextField!
    @IBOutlet weak var emailTextField: GALTextField!
    @IBOutlet weak var phoneNumberTextField: GALTextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var regularButtons: [UIButton]!
    @IBOutlet var editButtons: [UIButton]!
    @IBOutlet var textFields: [GALTextField]!
    
    //MARK:- Variables
    private lazy var dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    let datePicker = UIDatePicker()
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        editButton.isHidden = !presenter.editModeEnabled
        setupDatePicker()
        setupImageView()
    }

    //MARK:- IBActions
    @IBAction func dissmisTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        for i in 0 ..< textFields.count {
            let result = textFields[i].isValid()
            switch result {
            case .invalid(error: let error):
                if textFields[i].text == "" {
                    presenter.textFieldData[i].value = textFields[i].placeholder
                } else {
                    showError(with: error)
                    return
                }
            case .valid:
                presenter.textFieldData[i].value = textFields[i].text!
            }
        }
        editState(false)
        presenter.updateUserInfo()
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
        birthdayTextField.placeholder = dateFormatter.string(from: presenter.userData.birthYear!)
    }
    
    //MARK:- Main
    func updateSuccess() {
        editState(false)
        setupTextFields()
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showSuccess(withStatus: "Powodzenie")
    }
    
    private func editState(_ value: Bool) {
        regularButtons.forEach({ $0.isHidden = value })
        editButtons.forEach({ $0.isHidden = !value })
        for i in 0 ..< textFields.count {
            print(textFields[i])
            textFields[i].isUserInteractionEnabled = value
            textFields[i].text = nil
            textFields[i].delegate = self
            textFields[i].rule = presenter.textFieldData[i].validationRule
        }

    }
    
    private func setupTextFields() {
        firstNameTextField.text = presenter.userData.firstName
        secondNameTextField.text = presenter.userData.lastName
        emailTextField.text = presenter.userData.email
        phoneNumberTextField.text = presenter.userData.phone
        birthdayTextField.text = dateFormatter.string(from: presenter.userData.birthYear!)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.frame.origin.y )
        print((UIScreen.main.bounds.height / 2))
        if textField.frame.origin.y + 160.0 > (UIScreen.main.bounds.height / 2) {
            logoTopConstraint.constant = -(textField.frame.origin.y - 80.0)
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
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDoneTapped))
        toolbar.setItems([doneButton], animated: false)
        birthdayTextField.inputAccessoryView = toolbar
        birthdayTextField.inputView = datePicker
    }
    
    private func setupImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.GALBlue.cgColor
        
    }
    
    func updateUserImage(_ image: UIImage) {
        profileImageView.image = image
        self.view.layoutSubviews()
    }
    
    @objc private func datePickerDoneTapped() {
        birthdayTextField.text = "\(dateFormatter.string(from: datePicker.date))"
        phoneNumberTextField.becomeFirstResponder()
    }
}
