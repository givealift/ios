//
//  SearchViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController<SearchPresenter> {
    
    private let datePicker = UIDatePicker()
    @IBOutlet weak var toTextField: SugestiveTextField!
    @IBOutlet weak var fromTextField: SugestiveTextField!
    @IBOutlet weak var dateTextField: UITextField!
    private lazy var APIDateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        createDatePicker()
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        if let to = toTextField.selectedCityId(), let from = fromTextField.selectedCityId(), let dateString = dateTextField.text {
            presenter.findRoutesFor(from: from, to: to, date: dateString, delegate: self)
        }
    }
    
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    @objc private func donePressed() {
        dateTextField.text = "\(APIDateFormatter.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
}
