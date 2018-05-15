//
//  EditRouteInfoViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class EditRouteInfoViewController: BaseViewController<EditRouteInfoPresenter> {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func indirectsTapped(_ sender: Any) {
        presenter.showIndirectsView()
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        
    }
    
    @IBAction func detalisTapped(_ sender: Any) {
        
    }
    
    @IBAction func descriptionTapped(_ sender: Any) {
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
    }
    
    @IBAction func mainRouteTapped(_ sender: Any) {
        presenter.showMainRouteView()
    }
}
