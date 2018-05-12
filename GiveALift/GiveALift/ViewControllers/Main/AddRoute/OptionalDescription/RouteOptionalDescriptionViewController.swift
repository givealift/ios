//
//  RouteOptionalDescriptionViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteOptionalDescriptionViewController: BaseViewController<RouteOptionalDescriptionPresenter> {

    //MARK:- IBOutlets
    @IBOutlet weak var textView: UITextView!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
    }
    
    //MARK:- IBActions
    @IBAction func finishTapped(_ sender: Any) {
        
    }
}
