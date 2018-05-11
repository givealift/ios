//
//  RouteInfoViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteInfoViewController: BaseViewController<RouteInfoPresenter>, UITextFieldDelegate {

    //MARK:- IBOutlets
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var numberOfSeatsTextField: UITextField!
    
    
    //MARK:- VC's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.magenta
        self.hideKeyboardWhenTappedAround()
        setupKeyboards()
        setupTextFields()
    }

    
    //MARK:- IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    
    //MARK:- Main
    
    private func setupTextFields() {
        priceTextField.setPlaceholder(with: presenter.pricePlaceholder)
        numberOfSeatsTextField.setPlaceholder(with: presenter.numberOfSeatsPlaceholder)
        priceTextField.delegate = self
        numberOfSeatsTextField.delegate = self
    }
    
    private func setupKeyboards() {
        priceTextField.keyboardType = .numberPad
        numberOfSeatsTextField.keyboardType = .numberPad
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
        textField.text = nil
    }
}
