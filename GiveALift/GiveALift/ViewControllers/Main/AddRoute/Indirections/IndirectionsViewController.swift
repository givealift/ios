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
        sugestivetextField.placeholder = presenter.indirectTextFieldPlaceHolder
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 40))
        textField.backgroundColor = UIColor.white
        textField.placeholder = presenter.indirectLocationPlaceholder
        stackView.insertArrangedSubview(sugestivetextField, at: stackView.subviews.count - 2)
        stackView.insertArrangedSubview(textField, at: stackView.subviews.count - 2)
        stackViewHeightConstraint.constant += 40
        view.layoutSubviews()
        indirectCitiesTextfield.append(sugestivetextField)
        indirextCitiesLocations.append(textField)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let indirectCitys = indirectCitiesTextfield.filter({$0.selectedCityId() != nil}).map({$0.selectedCityId()!})
        let indirectLocations = indirextCitiesLocations.filter({!(($0.text == nil)||($0.text == ""))}).map({$0.text!})
        if indirectLocations.count == indirextCitiesLocations.count && indirectCitys.count == indirectCitiesTextfield.count {
            presenter.showRouteTimeView(indirectCitys: indirectCitys, indirectLocations: indirectLocations)
        } else {
            //MARK:- TODO
        }
    }
}
