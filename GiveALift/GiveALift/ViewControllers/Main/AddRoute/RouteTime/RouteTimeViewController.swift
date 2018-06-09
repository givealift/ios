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
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
    //MARK:- Constants
    private let datePicker = UIDatePicker()
    private let timePicker = UIDatePicker()
    
    //MARK:- Variables
    private var tagValue = 1
    private var currentTag: Int {
        get {
            tagValue += 1
            finishTime.tag = tagValue + 1
            return tagValue
        }
        set {}
    }
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
        setupDatePicker()
        setupTimePicker(textField: timeTextField)
        setupTimePicker(textField: finishTime)
        setupTextFields()
        addTextFieldsIfNeeded()
    }

    
    //MARK:- IBActions
    
    @IBAction func nextTapped(_ sender: Any) {
        presenter.isUpdating ? updateData() : classicWay()
    }
    
    //MARK:- Main
    
    private func classicWay() {
        let indirectDates = indirectionsTextField.filter({!(($0.text == nil)||($0.text == ""))}).map({$0.text!})
        if let date = dateTextField.text, date != "", let time = timeTextField.text, time != "", indirectDates.count == indirectionsTextField.count, let finishTime = finishTime.text, finishTime != "" {
            presenter.showRouteInfoView(departureDate: date, departureTime: time, finishTime: finishTime, indirectDates: indirectDates)
        } else {
            showError(with: "Wpisz poprawne dane")
        }
    }
    
    private func updateData() {
        var indirectDates: [String] = []
        for i in 0 ..< indirectionsTextField.count {
            if let date = indirectionsTextField[i].text, date != "" {
                indirectDates.append(date)
            } else {
                indirectDates.append(indirectionsTextField[i].placeholder!)
            }
        }
        if let date = dateTextField.text, date != "", let time = timeTextField.text, time != "", indirectDates.count == indirectionsTextField.count, let finishTime = finishTime.text, finishTime != "" {
            presenter.showRouteInfoView(departureDate: date, departureTime: time, finishTime: finishTime, indirectDates: indirectDates)
        } else {
            showError(with: "Wpisz poprawne dane")
        }
    }
    
    private func addTextFieldsIfNeeded() {
        guard let stops = presenter.route.stops else { return }
        for stop in stops {
            addInditectionTextfield(placeholder: stop.city.cityID.name() + " godzina przyjazdu")
            stackViewHeightConstraint.constant += 65
        }
        self.view.layoutSubviews()
    }
    
    private func setupTextFields() {
        dateTextField.placeholder = presenter.datePlaceholder
        timeTextField.placeholder = presenter.route.from.city.cityID.name() + presenter.timePlaceholder
        finishTime.placeholder = presenter.route.to.city.cityID.name() + presenter.finishPlaceholder
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
    
    private func addInditectionTextfield(placeholder: String) {
        let textField = GALTextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 50))
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDoneTapped))
        toolbar.setItems([doneButton], animated: false)
        indirectionsTextField.append(textField)
        textField.tag = currentTag
        textField.delegate = self
        textField.inputView = timePicker
        textField.inputAccessoryView = toolbar
        textField.placeholder = placeholder
        stackView.insertArrangedSubview(textField, at: stackView.subviews.count - 1)
    }
    
    @objc private func datePickerDoneTapped() {
        dateTextField.text = "\(dateFormatter.string(from: datePicker.date))"
        goToNextResponder(textField: dateTextField)
    }
    
    @objc private func timePickerDoneTapped() {
        selectedTextField?.text = "\(timeFormatter.string(from: timePicker.date))"
        goToNextResponder(textField: selectedTextField!)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
        if textField.frame.origin.y + 80.0 > (UIScreen.main.bounds.height / 2) {
            stackViewTopConstraint.constant = -(textField.frame.origin.y - 180.0)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutSubviews()
            }
        }
    }
    
    private func goToNextResponder(textField: UITextField) {
        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder?
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            dismissKeyboard()
        }
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
        stackViewTopConstraint.constant = 15
        UIView.animate(withDuration: 0.25) {
            self.view.layoutSubviews()
        }
    }
}
