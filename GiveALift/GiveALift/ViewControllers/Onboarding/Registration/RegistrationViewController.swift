//
//  RegistrationViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 29.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class RegistrationViewController: TextFieldViewController<RegistrationPresenter>, RegisterView {

    //MARK:- IBOutlets
    @IBOutlet weak var birthdayTextField: GALTextField!
    @IBOutlet weak var compatibilePasswordTextField: GALTextField!
    @IBOutlet weak var passwordTextField: GALTextField!
    @IBOutlet weak var mailTextField: GALTextField!
    @IBOutlet weak var lastNameTextField: GALTextField!
    @IBOutlet weak var nameTextField: GALTextField!
    @IBOutlet weak var phoneTextField: GALTextField!
    @IBOutlet var textFields: [GALTextField]!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
    //MARK:- Constants
    private let datePicker = UIDatePicker()
    private lazy var dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupDatePicker()
    }
    
    //MARK:- Main
    private func setupTextField() {
        for i in 0 ..< textFields.count {
            textFields[i].tag = i
            textFields[i].delegate = self
            textFields[i].placeholder = presenter.textFieldsData[i].labelText
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
    
    @objc private func datePickerDoneTapped() {
        birthdayTextField.text = "\(dateFormatter.string(from: datePicker.date))"
        phoneTextField.becomeFirstResponder()
    }
    
    //MARK:- IBActions
    @IBAction func registerTapped(_ sender: Any) {
        
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.frame.origin.y + 40.0 > (UIScreen.main.bounds.height / 2) {
            stackViewTopConstraint.constant = -(textField.frame.origin.y - 160.0)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutSubviews()
            }
        }
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
        stackViewTopConstraint.constant = 10
        UIView.animate(withDuration: 0.25) {
            self.view.layoutSubviews()
        }
    }
}

