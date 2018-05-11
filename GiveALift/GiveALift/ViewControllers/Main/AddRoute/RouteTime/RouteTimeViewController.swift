//
//  RouteTimeViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteTimeViewController: BaseViewController<RouteTimePresenter>, UITextFieldDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!

    //MARK:- Constants
    private let datePicker = UIDatePicker()
    private let timePicker = UIDatePicker()
    
    private lazy var dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    private lazy var timeFormatter: DateFormatter = {
        $0.dateFormat = "HH:mm"
        return $0
    }(DateFormatter())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        self.hideKeyboardWhenTappedAround()
        setupDatePicker()
        setupTimePicker()
        setupTextFields()
    }
    
    //MARK:- IBActions
    
    @IBAction func nextTapped(_ sender: Any) {
        presenter.showRouteInfoView()
    }
    
    //MARK:- Main
    
    private func setupTextFields() {
        dateTextField.setPlaceholder(with: presenter.datePlaceholder)
        timeTextField.setPlaceholder(with: presenter.timePlaceholder)
        dateTextField.delegate = self
        timeTextField.delegate = self
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDoneTapped))
        toolbar.setItems([doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    private func setupTimePicker() {
        timePicker.datePickerMode = .time
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDoneTapped))
        toolbar.setItems([doneButton], animated: false)
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = timePicker
    }
    
    @objc private func datePickerDoneTapped() {
        dateTextField.text = "\(dateFormatter.string(from: datePicker.date))"
        timeTextField.becomeFirstResponder()
    }
    
    @objc private func timePickerDoneTapped() {
        timeTextField.text = "\(timeFormatter.string(from: timePicker.date))"
        self.view.endEditing(true)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
        textField.text = nil
    }
}
