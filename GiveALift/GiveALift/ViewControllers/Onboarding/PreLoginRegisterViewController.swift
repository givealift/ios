//
//  LoginViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 23.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class PreLoginRegisterViewController: UIViewController {
    
    weak var connector: RootConnectorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerTapped(_ sender: Any) {
        performSegue(withIdentifier: Segues.goToRegister, sender: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Onboarding", bundle: Bundle.main)
        let vc : LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //vc.connector = connector
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
