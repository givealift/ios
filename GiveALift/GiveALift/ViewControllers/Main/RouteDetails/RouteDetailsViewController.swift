//
//  RouteDetailsViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteDetailsViewController: BaseViewController<RouteDetailsPresenter> {

    @IBOutlet weak var routesStackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var routesStackView: UIStackView!
    @IBOutlet weak var numberOfSeats: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
    }
    
    @IBAction func reserveTapped(_ sender: Any) {
        
    }
}
