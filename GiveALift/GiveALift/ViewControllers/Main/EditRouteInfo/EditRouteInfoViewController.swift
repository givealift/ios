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
        setupSaveButton()
    }

    @IBAction func indirectsTapped(_ sender: Any) {
        presenter.showIndirectsView()
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        
    }
    
    @IBAction func detalisTapped(_ sender: Any) {
        presenter.showRouteInfoView()
    }
    
    @IBAction func descriptionTapped(_ sender: Any) {
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
    }
    
    @IBAction func mainRouteTapped(_ sender: Any) {
        presenter.showMainRouteView()
    }
    
    private func setupSaveButton() {
         self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Zapisz", style: .plain, target: self, action: #selector(saveTapped)), animated: true)
    }
    
    @objc func saveTapped() {
        presenter.updateToServer()
    }
}
