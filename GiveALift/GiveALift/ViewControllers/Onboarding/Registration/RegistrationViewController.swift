//
//  RegistrationViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 29.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class RegistrationViewController: BaseViewController<RegistrationPresenter> {

    @IBOutlet weak var birthdayTextField: GALTextField!
    @IBOutlet weak var compatibilePasswordTextField: GALTextField!
    @IBOutlet weak var passwordTextField: GALTextField!
    @IBOutlet weak var mailTextField: GALTextField!
    @IBOutlet weak var lastNameTextField: GALTextField!
    @IBOutlet weak var nameTextField: GALTextField!
    @IBOutlet weak var phoneTextField: GALTextField!
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
    }
    

}
