//
//  IndirectionsViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class IndirectionsViewController: AddRouteViewController<IndirectionsPresenter> {
    
    //MARK:- Variables
    
    private var indirectCitiesTextfield: [SugestiveTextField] = []
    private var indirextCitiesLocations: [UITextField] = []
    
    
    //MARK:- IBOutlets

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- VC's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if presenter.isUpdating { checkIfTextFiledIsNeeded() }
    }
    
    
    //MARK:- IBActions

    @IBAction func addIndirectionTapped(_ sender: Any) {
        addTextFields(placeholder: presenter.indirectTextFieldPlaceHolder, locationPlaceholder: presenter.indirectLocationPlaceholder)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        presenter.isUpdating ? updateData() : classicWay()
    }
    
    private func updateData() {
        var indirects = [Indirect]()
        for i in 0 ..< indirectCitiesTextfield.count {
            let cityText = indirectCitiesTextfield[i].text == "" ? checkIfIsOldValue(index: i)?.city.cityID : indirectCitiesTextfield[i].selectedCityId()
            let locationText = indirextCitiesLocations[i].text == "" ? checkIfIsOldValue(index: i)?.placeOfMeeting : indirextCitiesLocations[i].text
            if let cityID = cityText, let location = locationText {
                indirects.append(Indirect(cityID: cityID, location: location))
            }
        }
        if indirects.count == indirectCitiesTextfield.count && indirects.count == indirextCitiesLocations.count {
            presenter.showEditRouteInfo(indirects: indirects)
        } else {
            //MARK:- TODO info o źle podanych danych
        }
    }
    
    private func checkIfIsOldValue(index: Int) -> Location? {
        guard let numberOfStops = presenter.route.stops?.count else { return nil }
        return index < numberOfStops ?  presenter.route.stops?[index] : nil
    }
    
    private func classicWay() {
        let indirectCitys = indirectCitiesTextfield.filter({$0.selectedCityId() != nil}).map({$0.selectedCityId()!})
        let indirectLocations = indirextCitiesLocations.filter({!(($0.text == nil)||($0.text == ""))}).map({$0.text!})
        if indirectLocations.count == indirextCitiesLocations.count && indirectCitys.count == indirectCitiesTextfield.count {
            presenter.showRouteTimeView(indirectCitys: indirectCitys, indirectLocations: indirectLocations)
        } else {
            //MARK:- TODO wyświetlić błąd
        }
    }
    
    private func checkIfTextFiledIsNeeded() {
        presenter.route.stops?.forEach({ addTextFields(placeholder: $0.placeOfMeeting, locationPlaceholder: $0.placeOfMeeting) })
    }
    
    private func addTextFields(placeholder: String, locationPlaceholder: String) {
        let sugestivetextField = SugestiveTextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 40))
        sugestivetextField.backgroundColor = UIColor.white
        sugestivetextField.placeholder = placeholder
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 40))
        textField.backgroundColor = UIColor.white
        textField.placeholder = locationPlaceholder
        stackView.insertArrangedSubview(sugestivetextField, at: stackView.subviews.count - 2)
        stackView.insertArrangedSubview(textField, at: stackView.subviews.count - 2)
        stackViewHeightConstraint.constant += 40
        view.layoutSubviews()
        indirectCitiesTextfield.append(sugestivetextField)
        indirextCitiesLocations.append(textField)
    }
}
