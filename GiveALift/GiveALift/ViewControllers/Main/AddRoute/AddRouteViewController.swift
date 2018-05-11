//
//  AddRouteViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class AddRouteViewController: BaseViewController<AddRoutePresenter> {

    @IBOutlet weak var fromTextfield: SugestiveTextField!
    
    @IBOutlet weak var toTextField: SugestiveTextField!
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        fromTextfield.setPlaceholder(with: "Podaj miasto startowe")
        toTextField.setPlaceholder(with: "Podaj miasto końcowe")
    }

}
