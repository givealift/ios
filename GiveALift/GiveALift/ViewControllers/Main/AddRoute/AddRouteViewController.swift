//
//  AddRouteViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class AddRouteViewController: BaseViewController<AddRoutePresenter>, UITextFieldDelegate {
    
    private var indirectCitiesTextfield: [SugestiveTextField] = []

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
    @IBAction func addIndirectCity(_ sender: Any) {
        let textField = SugestiveTextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 40))
        textField.backgroundColor = UIColor.white
        textField.setPlaceholder(with: presenter.indirectTextFieldPlaceHolder)
        stackView.insertArrangedSubview(textField, at: 1)
        stackViewHeightConstraint.constant += 40
        view.layoutSubviews()
        indirectCitiesTextfield.append(textField)
    }
    
    @IBAction func next(_ sender: Any) {
        if let fromCityId = fromTextfield.selectedCityId(), let toCityId = toTextField.selectedCityId(), let from = fromLocationTextField.text, let to = toLocationTextField.text {
                presenter.showRouteTimeView(routeLocation: RouteLocation(fromCityId: fromCityId, toCityId: toCityId, from: from, to: to))
        }
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
