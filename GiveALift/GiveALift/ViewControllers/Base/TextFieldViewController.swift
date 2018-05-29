//
//  TextFieldViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 22.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class TextFieldViewController<T>: BaseViewController<T>, UITextFieldDelegate where T: BasePresenter  {

    private var errorView: ErrorMessage!
    private var errorViewYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addErrorMessageView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func hideErrorMessage() {
        self.errorViewYConstraint.constant = 0
        UIView.animate(withDuration: 0.4, delay: 1.4, options: .curveEaseOut, animations: {
            self.view.layoutSubviews()
        })
    }
    
    func showError(with message: String) {
        errorView.setErrorMessage(message)
        self.errorViewYConstraint.constant = 50
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutSubviews()
        }) { (_) in
            self.hideErrorMessage()
        }
    }
    
    private func addErrorMessageView() {
        let errorView = ErrorMessage(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.errorView = errorView
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        let leading = NSLayoutConstraint(item: errorView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: errorView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: errorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        let yConstraint = NSLayoutConstraint(item: errorView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        errorViewYConstraint = yConstraint
        view.addConstraints([leading, trailing, height, yConstraint])
    }
}
