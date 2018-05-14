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
        setupUserInfoButton()
        setBackgroundImage()
    }

    @IBAction func searchTapped(_ sender: Any) {
        presenter.showSearchView()
    }
    
    @IBAction func addTapped(_ sender: Any) {
        presenter.showAddRouteView()
    }
    
    private func setBackgroundImage() {
        let background = UIImageView(image: #imageLiteral(resourceName: "background2"))
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(background, at: 0)
        let topConstraint = NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: background, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: background, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
    //MARK:- Main
    private func setupUserInfoButton() {
        
    }
}
