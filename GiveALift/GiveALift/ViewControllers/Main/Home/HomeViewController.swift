//
//  HomeViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class HomeViewController: TextFieldViewController<HomePresenter>, HomeView {

    //MARK:- IBOutlets
    @IBOutlet weak var dateTextField: GALTextField!
    @IBOutlet weak var toTextField: SugestiveTextField!
    @IBOutlet weak var fromTextField: SugestiveTextField!
    @IBOutlet weak var sideMenu: GALSideMenu!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    private lazy var APIDateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    private var isSideMenuHidden: Bool = true {
        didSet {
            self.sideMenuLeadingConstraint.constant = isSideMenuHidden ? -sideMenu.frame.size.width : 0
            UIView.animate(withDuration: 0.25) {
                self.view.layoutSubviews()
            }
        }
    }
    
    //MARK:- Constants
    private let datePicker = UIDatePicker()
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInfoButton()
        setBackgroundImage()
        setupTextFields()
        createDatePicker()
    }

    //MARK:- IBActions
    @IBAction func searchTapped(_ sender: Any) {
        if let to = toTextField.selectedCityId(), let from = fromTextField.selectedCityId(), let dateString = dateTextField.text, dateString != "" {
            presenter.showRoutesView(from: from, to: to, date: dateString)
        } else {
            showError(with: presenter.emptyData)
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        presenter.showAddRouteView()
    }
    
    //MARK:- Main
    private func setupTextFields() {
        fromTextField.placeholder = presenter.fromPlaceholder
        toTextField.placeholder = presenter.toPlaceholder
        dateTextField.placeholder = presenter.datePlaceholder
        fromTextField.tag = 0
        toTextField.tag = 1
        dateTextField.tag = 2
        fromTextField.delegate = self
        toTextField.delegate = self
        dateTextField.delegate = self
    }
    
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    @objc private func donePressed() {
        dateTextField.text = "\(APIDateFormatter.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
    
    private func setBackgroundImage() {
        let background = UIImageView(image: #imageLiteral(resourceName: "background2"))
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(background, at: 0)
        let topConstraint = NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: background, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: background, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
    //MARK:- Main
    private func setupUserInfoButton() {
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "background1").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(userInfoTapped)), animated: true)
    }
    
    @objc private func userInfoTapped() {
        //presenter.showUserInfoView()
        isSideMenuHidden = !isSideMenuHidden 
    }
}
