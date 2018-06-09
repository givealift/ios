//
//  RouteInfoViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteInfoViewController: AddRouteViewController<RouteInfoPresenter> {

    //MARK:- IBOutlets
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var numberOfSeatsTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    //MARK:- VC's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupKeyboards()
        presenter.isUpdating ? setupPlaceholderWithOldValues() : setupDefaultPlaceholder()
        presenter.isUpdating ? nextButton.setTitle("Gotowe",for: .normal) : nextButton.setTitle("Dalej",for: .normal)
    }

    
    //MARK:- IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        presenter.isUpdating ? updateData() : classicWay()
    }
    
    
    //MARK:- Main
    
    private func updateData() {
        let priceText = priceTextField.text == "" ? presenter.route.price : Int(priceTextField.text!)!
        let numberOfSeatsText = numberOfSeatsTextField.text == "" ? presenter.route.numberOfSeats : Int(numberOfSeatsTextField.text!)!
        if let price = priceText, let numberOfSeats = numberOfSeatsText {
            presenter.showEditRouteInfoView(price: price, numberOfSeats: numberOfSeats)
        } else {
            showError(with: "Podane dane są niepoprawne")
        }
    }
    
    private func classicWay() {
        if let price = priceTextField.text, let numberOfSeats = numberOfSeatsTextField.text, price != "", numberOfSeats != "" {
            presenter.showRouteOptionalDescriptionView(price: Int(price)! , numberOfSeats: Int(numberOfSeats)!)
        } else {
            showError(with: "Podane dane są niepoprawne")
        }
    }
    
    private func setupPlaceholderWithOldValues() {
        priceTextField.placeholder = String(describing: presenter.route.price!)
        numberOfSeatsTextField.placeholder = String(describing: presenter.route.numberOfSeats!)
    }
    
    private func setupDefaultPlaceholder() {
        priceTextField.placeholder = presenter.pricePlaceholder
        numberOfSeatsTextField.placeholder = presenter.numberOfSeatsPlaceholder
    }
    
    private func setupKeyboards() {
        priceTextField.keyboardType = .numberPad
        numberOfSeatsTextField.keyboardType = .numberPad
    }
}
