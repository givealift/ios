//
//  HomeViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController<HomePresenter> {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
    }

    @IBAction func searchTapped(_ sender: Any) {
        let _ = SearchConnector(navigationController: self.navigationController!)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let _ = AddRouteConnector(navigationController: self.navigationController!)
    }
}
