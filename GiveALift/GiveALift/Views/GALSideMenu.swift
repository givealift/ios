//
//  GALSideMenu.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 04.06.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class GALSideMenu: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK:- Main
    private func setupView() {
        Bundle.main.loadNibNamed("GALSideMenu", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func profileTapped(_ sender: Any) {
    }

    @IBAction func subscribedRoutesTapped(_ sender: Any) {
    }
    @IBAction func yourRoutesTapped(_ sender: Any) {
    }
}
