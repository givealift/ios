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
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- Constants
    private let datePicker = UIDatePicker()
    private let timePicker = UIDatePicker()
    
    //MARK:- Variables
    private var selectedTextField: UITextField?
    private var indirectionsTextField = [UITextField]()
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
        addTextFieldsIfNeeded()
    }

    
    //MARK:- IBActions
    
    @IBAction func nextTapped(_ sender: Any) {
        let indirectDates = indirectionsTextField.filter({!(($0.text == nil)||($0.text == ""))}).map({$0.text!})
        if let date = dateTextField.text, date != "", let time = timeTextField.text, time != "", indirectDates.count == indirectionsTextField.count {
            presenter.showRouteInfoView(departureDate: "2018-05-08", departureTime: "21:15", indirectDates: indirectDates)
        }
    }
    
    //MARK:- Main
    
    private func addTextFieldsIfNeeded() {
        for _ in presenter.route.stops! {
            addInditectionTextfield()
            stackViewHeightConstraint.constant += 30
        }
        self.view.layoutSubviews()
    }
    
    private func setupTextFields() {
        dateTextField.placeholder = presenter.datePlaceholder
        timeTextField.placeholder = presenter.timePlaceholder
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
    
    private func addInditectionTextfield() {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDoneTapped))
        toolbar.setItems([doneButton], animated: false)
        indirectionsTextField.append(textField)
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        textField.inputView = timePicker
        textField.inputAccessoryView = toolbar
        stackView.insertArrangedSubview(textField, at: stackView.subviews.count - 1)
    }
    
    @objc private func datePickerDoneTapped() {
        dateTextField.text = "\(dateFormatter.string(from: datePicker.date))"
        timeTextField.becomeFirstResponder()
    }
    
    @objc private func timePickerDoneTapped() {
        selectedTextField?.text = "\(timeFormatter.string(from: timePicker.date))"
        self.view.endEditing(true)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
    }
}
