//
//  RouteOptionalDescriptionViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit
import SVProgressHUD

class RouteOptionalDescriptionViewController: AddRouteViewController<RouteOptionalDescriptionPresenter>, UITextViewDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var textView: UITextView!
    private var userEdit = false
    @IBOutlet weak var readyButton: GALBlueButton!
    @IBOutlet weak var addButton: GALPinkButton!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.isUpdating ? setupTextView(placeholder: presenter.route.description) : setupTextView(placeholder: presenter.textViewPlaceholder)
        readyButton.isHidden = presenter.isUpdating ? false : true
        addButton.isHidden = !readyButton.isHidden
    }
    
    //MARK:- IBActions
    @IBAction func finishTapped(_ sender: Any) {
        if userEdit == true {
            presenter.showHomeView(description: textView.text)
        } else {
            presenter.showHomeView(description: nil)
        }
    }
    
    @IBAction func readyTapped(_ sender: Any) {
        if userEdit == true {
            presenter.showPreviousView(description: textView.text)
        } else {
            presenter.showPreviousView(description: nil)
        }
    }
    
    //MARK:- Main
    private func setupTextView(placeholder: String?) {
        textView.delegate = self
        textView.text = placeholder
        textView.textColor = UIColor.lightGray
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 3.0
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        userEdit = true
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = presenter.textViewPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
