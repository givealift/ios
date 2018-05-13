//
//  IndirectionsViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class IndirectionsViewController: BaseViewController<IndirectionsPresenter> {
    
    //MARK:- Variables
    
    private var indirectCitiesTextfield: [SugestiveTextField] = []
    private var indirextCitiesLocations: [UITextField] = []
    
    
    //MARK:- IBOutlets

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    
    //MARK:- VC's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.hideKeyboardWhenTappedAround()
    }
    
    
    //MARK:- IBActions

    @IBAction func addIndirectionTapped(_ sender: Any) {
        let sugestivetextField = SugestiveTextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 40))
        sugestivetextField.backgroundColor = UIColor.white
        sugestivetextField.setPlaceholder(with: presenter.indirectTextFieldPlaceHolder)
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 40))
        textField.backgroundColor = UIColor.white
        textField.setPlaceholder(with: presenter.indirectLocationPlaceholder)
        stackView.insertArrangedSubview(sugestivetextField, at: stackView.subviews.count - 2)
        stackView.insertArrangedSubview(textField, at: stackView.subviews.count - 2)
        stackViewHeightConstraint.constant += 40
        view.layoutSubviews()
        indirectCitiesTextfield.append(sugestivetextField)
        indirextCitiesLocations.append(textField)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
//        if let _ = indirextCitiesLocations.first(where: { $0.text == nil }),
//            let _ = indirectCitiesTextfield.first(where: { $0.text == nil }) {
//
//        }
        //MARK:- TODO zmienić
        presenter.showRouteTimeView(indirectCitys: [], indirectLocations: [])
    }
}
