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
    
    @IBAction func dateTapped(_ sender: Any) {
        presenter.showRouteTimeView()
    }
    
    @IBAction func detalisTapped(_ sender: Any) {
        presenter.showRouteInfoView()
    }
    
    @IBAction func descriptionTapped(_ sender: Any) {
        presenter.showOptionalDescriotionView()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        presenter.deleteRoute()
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
