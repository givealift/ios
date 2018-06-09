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
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
    }
    
    //MARK:- IBActions
    @IBAction func finishTapped(_ sender: Any) {
        presenter.showHomeView(description: textView.text)
    }
    
    //MARK:- Main
    private func setupTextView() {
        textView.delegate = self
        textView.text = presenter.textViewPlaceholder
        textView.textColor = UIColor.lightGray
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 3.0
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
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
