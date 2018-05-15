//
//  MainRouteViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class MainRouteViewController: AddRouteViewController<MainRoutePresenter> {
    
    //MARK:- IBOutlets
    @IBOutlet weak var fromTextField: SugestiveTextField!
    @IBOutlet weak var toLocationTextField: GALTextField!
    @IBOutlet weak var fromLocationTextField: GALTextField!
    @IBOutlet weak var toTextField: SugestiveTextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        presenter.isUpdating ? setPlaceholderWithOldValues() : setDefaultPlaceholder()
        nextButton.titleLabel?.text = presenter.isUpdating ? "Gotowe" : "Dalej"
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        presenter.isUpdating ? updateData() : classicWay()
    }
    
    //MARK:- Main
    
    private func classicWay() {
        if let fromCityId = fromTextField.selectedCityId(), let toCityId = toTextField.selectedCityId(), let from = fromLocationTextField.text, let to = toLocationTextField.text, from != "", to != "" {
            
            presenter.showIndirectionView(fromCityId: fromCityId, fromLocation: from, toCityId: toCityId, toLocation: to)
        } else {
            //MARK:- TODO info o niepodanych danych
            presenter.showIndirectionView(fromCityId: 1, fromLocation: "dsa", toCityId: 3, toLocation: "23")
        }
    }
    
    private func updateData() {
        let fromText = fromTextField.text == "" ? presenter.route.from.city.cityID : fromTextField.selectedCityId()
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
        fromTextField.placeholder = presenter.fromTextFieldPlaceholder
        toTextField.placeholder = presenter.toTextFieldPlaceholder
        toLocationTextField.placeholder = presenter.toLocationPlaceholder
        fromLocationTextField.placeholder = presenter.fromLocationPlaceholder
    }
    
    private func setPlaceholderWithOldValues() {
        fromTextField.placeholder = presenter.route.from.city.name
        toTextField.placeholder = presenter.route.to.city.name
        toLocationTextField.placeholder = presenter.route.to.placeOfMeeting
        fromLocationTextField.placeholder = presenter.route.from.placeOfMeeting
    }

}
