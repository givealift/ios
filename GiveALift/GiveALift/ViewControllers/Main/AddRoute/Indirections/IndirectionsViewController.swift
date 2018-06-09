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
    private var tagValue = 10
    private var currentTag: Int {
        get {
            tagValue -= 1
            return (tagValue)
        }
    }
    
    //MARK:- IBOutlets

    @IBOutlet weak var buttonsStackViewHeightConstrint: NSLayoutConstraint!
    @IBOutlet weak var deleteIndirect: UIButton!
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
        if indirectCitiesTextfield.count <= 3 {
        addTextFields(placeholder: presenter.indirectTextFieldPlaceHolder, locationPlaceholder: presenter.indirectLocationPlaceholder)
        if indirectCitiesTextfield.count != 0 {
            deleteIndirect.isHidden = false
            buttonsStackViewHeightConstrint.constant = 150
            UIView.animate(withDuration: 0.5) {
                self.view.layoutSubviews()
            }
        }
        } else {
            showError(with: "Możesz dodać maksymalnie 3 przystanki")
        }
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        deleteIndirectFromView()
        if indirectCitiesTextfield.count == 0 {
            deleteIndirect.isHidden = true
            buttonsStackViewHeightConstrint.constant = 100
            UIView.animate(withDuration: 0.5) {
                self.view.layoutSubviews()
            }
        }
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        presenter.isUpdating ? updateData() : classicWay()
    }
    
    private func deleteIndirectFromView() {
        let index = indirectCitiesTextfield.count - 1
        stackView.removeArrangedSubview(indirectCitiesTextfield[index])
        indirectCitiesTextfield[index].removeFromSuperview()
        stackView.removeArrangedSubview(indirextCitiesLocations[index])
        indirextCitiesLocations[index].removeFromSuperview()
        indirectCitiesTextfield.remove(at: index)
        indirextCitiesLocations.remove(at: index)
        stackViewHeightConstraint.constant -= 130
        view.layoutSubviews()
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
            showError(with: "Wpisz poprawne dane")
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
             showError(with: "Wpisz poprawne dane")
        }
    }
    
    private func checkIfTextFiledIsNeeded() {
        presenter.route.stops?.forEach({ addTextFields(placeholder: $0.placeOfMeeting, locationPlaceholder: $0.placeOfMeeting) })
    }
    
    private func addTextFields(placeholder: String, locationPlaceholder: String) {
        let sugestivetextField = SugestiveTextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 50))
        sugestivetextField.placeholder = placeholder
        sugestivetextField.delegate = self
        let textField = GALTextField(frame: CGRect(x: 0, y: 0, width: stackView.frame.width, height: 50))
        textField.placeholder = locationPlaceholder
        textField.delegate = self
        textField.tag = currentTag
        sugestivetextField.tag = currentTag
        stackView.insertArrangedSubview(textField, at: 2*indirectCitiesTextfield.count )
        stackView.insertArrangedSubview(sugestivetextField, at: 2*indirectCitiesTextfield.count)
        stackViewHeightConstraint.constant += 130
        view.layoutSubviews()
        indirectCitiesTextfield.append(sugestivetextField)
        indirextCitiesLocations.append(textField)
    }
}
