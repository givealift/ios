//
//  RouteInfoViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteInfoViewController: BaseViewController<RouteInfoPresenter> {

    //MARK:- IBOutlets
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var numberOfSeatsTextField: UITextField!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.magenta
        self.hideKeyboardWhenTappedAround()
        setupKeyboards()
        priceTextField.becomeFirstResponder()
    }

    //MARK:- IBActions
    @IBAction func nextButtonTapped(_ sender: Any) {
        
    }
    
    private func setupKeyboards() {
        priceTextField.keyboardType = .numberPad
        numberOfSeatsTextField.keyboardType = .numberPad
    }
}
