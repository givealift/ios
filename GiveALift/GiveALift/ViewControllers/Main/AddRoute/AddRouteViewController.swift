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
        setupTextFields()
    }

    //MARK:- IBActions
    
    @IBAction func next(_ sender: Any) {
        //MARK:- TODO odkomentować
//        if let fromCityId = fromTextfield.selectedCityId(), let toCityId = toTextField.selectedCityId(), let from = fromLocationTextField.text, let to = toLocationTextField.text {
//                presenter.showIndirectionView(routeLocation: RouteLocation(fromCityId: fromCityId, toCityId: toCityId, from: from, to: to))
//        }
        let addRoute = AddRoute()
        addRoute.from = RouteLocation()
        addRoute.from.city.cityId = 1
        addRoute.from.placeOfMeeting = "siusiaczek"
        addRoute.to = RouteLocation()
        addRoute.to.city.cityId = 2
        addRoute.to.placeOfMeeting = "pizdeczka"
        presenter.showIndirectionView(addRoute: addRoute)
        
        //MARK:- TODO info o niepodanych danych
    }
    
    //MARK:- Main
    private func setupTextFields() {
        fromTextfield.setPlaceholder(with: presenter.fromTextFieldPlaceholder)
        toTextField.setPlaceholder(with: presenter.toTextFieldPlaceholder)
        toLocationTextField.setPlaceholder(with: presenter.toLocationPlaceholder)
        fromLocationTextField.setPlaceholder(with: presenter.fromLocationPlaceholder)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
        textField.text = nil
    }
}
