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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        self.hideKeyboardWhenTappedAround()
        presenter.isUpdating ? setPlaceholderWithOldValues() : setDefaultPlaceholder()
        nextButton.titleLabel?.text = presenter.isUpdating ? "Gotowe" : "Dalej"
    }

    //MARK:- IBActions
    
    @IBAction func next(_ sender: Any) {
        presenter.isUpdating ? updateData() : classicWay()
    }
    
    
    //MARK:- Main
    
    private func classicWay() {
        if let fromCityId = fromTextfield.selectedCityId(), let toCityId = toTextField.selectedCityId(), let from = fromLocationTextField.text, let to = toLocationTextField.text, from != "", to != "" {
            
            presenter.showIndirectionView(fromCityId: fromCityId, fromLocation: from, toCityId: toCityId, toLocation: to)
        } else {
            //MARK:- TODO info o niepodanych danych
            presenter.showIndirectionView(fromCityId: 1, fromLocation: "dsa", toCityId: 3, toLocation: "23")
        }
    }
    
    private func updateData() {
        let fromText = fromTextfield.text == "" ? presenter.route.from.city.cityID : fromTextfield.selectedCityId()
        let toText = toTextField.text == "" ? presenter.route.to.city.cityID : toTextField.selectedCityId()
        let from = fromLocationTextField.text == "" ? presenter.route.from.placeOfMeeting : fromLocationTextField.text
        let to = toLocationTextField.text == "" ? presenter.route.from.placeOfMeeting : toLocationTextField.text
        if let fromCityID = fromText, let toCityID = toText, let fromLocation = from, let toLocation = to {
            presenter.showIndirectionView(fromCityId: fromCityID, fromLocation: fromLocation, toCityId: toCityID, toLocation: toLocation)
        } else {
            //MARK:- TODO wyświetlić błąd
        }
    }
    
    private func setDefaultPlaceholder() {
        fromTextfield.placeholder = presenter.fromTextFieldPlaceholder
        toTextField.placeholder = presenter.toTextFieldPlaceholder
        toLocationTextField.placeholder = presenter.toLocationPlaceholder
        fromLocationTextField.placeholder = presenter.fromLocationPlaceholder
    }
    
    private func setPlaceholderWithOldValues() {
        fromTextfield.placeholder = presenter.route.from.city.name
        toTextField.placeholder = presenter.route.to.city.name
        toLocationTextField.placeholder = presenter.route.to.placeOfMeeting
        fromLocationTextField.placeholder = presenter.route.from.placeOfMeeting
    }
}
