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
        if let price = priceTextField.text, let numberOfSeats = numberOfSeatsTextField.text, price != "", numberOfSeats != "" {
            print(priceTextField.text)
            presenter.showRouteOptionalDescriptionView(price: Int(price)! , numberOfSeats: Int(numberOfSeats)!)
        } else {
            //MARK:- TODO error
            print("podaj dane")
        }
    }
    
    
    //MARK:- Main
    
    private func setupTextFields() {
        priceTextField.placeholder = presenter.pricePlaceholder
        numberOfSeatsTextField.placeholder = presenter.numberOfSeatsPlaceholder
    }
    
    private func setupKeyboards() {
        priceTextField.keyboardType = .numberPad
        numberOfSeatsTextField.keyboardType = .numberPad
    }
}
