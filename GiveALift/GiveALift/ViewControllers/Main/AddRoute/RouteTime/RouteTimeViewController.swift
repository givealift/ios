//
//  RouteTimeViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteTimeViewController: AddRouteViewController<RouteTimePresenter> {

    //MARK:- IBOutlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var finishTime: UITextField!
    
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
        self.hideKeyboardWhenTappedAround()
        setupDatePicker()
        setupTimePicker(textField: timeTextField)
        setupTimePicker(textField: finishTime)
        setupTextFields()
        addTextFieldsIfNeeded()
    }

    
    //MARK:- IBActions
    
    @IBAction func nextTapped(_ sender: Any) {
        let indirectDates = indirectionsTextField.filter({!(($0.text == nil)||($0.text == ""))}).map({$0.text!})
        if let date = dateTextField.text, date != "", let time = timeTextField.text, time != "", indirectDates.count == indirectionsTextField.count, let finishTime = finishTime.text, finishTime != "" {
            presenter.showRouteInfoView(departureDate: date, departureTime: time, finishTime: finishTime, indirectDates: indirectDates)
        } else {
            //MARK:- TODO wyśietlić błąd
        }
    }
    
    //MARK:- Main
    
    private func addTextFieldsIfNeeded() {
        guard let stops = presenter.route.stops else { return }
        for _ in stops {
            addInditectionTextfield()
            stackViewHeightConstraint.constant += 30
        }
        self.view.layoutSubviews()
    }
    
    private func setupTextFields() {
        dateTextField.placeholder = presenter.datePlaceholder
        timeTextField.placeholder = presenter.timePlaceholder
        finishTime.placeholder = presenter.finishPlaceholder
        dateTextField.delegate = self
        timeTextField.delegate = self
        finishTime.delegate = self
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
    
    private func setupTimePicker(textField: UITextField) {
        timePicker.datePickerMode = .time
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDoneTapped))
        toolbar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = timePicker
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
