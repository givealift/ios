//
//  AddRouteViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class AddRouteViewController: BaseViewController<AddRoutePresenter>, UITextFieldDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var fromTextfield: SugestiveTextField!
    @IBOutlet weak var fromLocationTextField: UITextField!
    @IBOutlet weak var toTextField: SugestiveTextField!
    @IBOutlet weak var toLocationTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        self.hideKeyboardWhenTappedAround()
        presenter.isUpdating ? setPlaceholderWithOldValues()() : setDefaultPlaceholder()()
    }

    //MARK:- IBActions
    
    @IBAction func next(_ sender: Any) {
        if let fromCityId = fromTextfield.selectedCityId(), let toCityId = toTextField.selectedCityId(), let from = fromLocationTextField.text, let to = toLocationTextField.text, from != "", to != "" {
    
            presenter.showIndirectionView(fromCityId: fromCityId, fromLocation: from, toCityId: toCityId, toLocation: to)
        } else {
            //MARK:- TODO info o niepodanych danych
            presenter.showIndirectionView(fromCityId: 1, fromLocation: "dsa", toCityId: 3, toLocation: "23")
        }
    }
    
    //MARK:- Main
    private func setDefaultPlaceholder() {
        fromTextfield.placeholder = presenter.fromTextFieldPlaceholder
        toTextField.placeholder = presenter.toTextFieldPlaceholder
        toLocationTextField.placeholder = presenter.toLocationPlaceholder
        fromLocationTextField.placeholder = presenter.fromLocationPlaceholder
    }
    
    private func setPlaceholderWithOldValues() {
        
    }
}
