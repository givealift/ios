//
//  LoginViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 23.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class PreLoginRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func registerTapped(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToRegister, sender: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToLogin, sender: nil)
    }
}
