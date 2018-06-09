//
//  GALSideMenu.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 04.06.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol SideMenuDelegate: class {
    func profileTapped()
    func userRoutesTapped()
    func reservedRoutesTapped()
    func logOutTapped()
}

final class GALSideMenu: UIView {
    
    @IBOutlet var contentView: UIView!
    weak var delegate: SideMenuDelegate?
    
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
        delegate?.profileTapped()
    }

    @IBAction func logOutTapped(_ sender: Any) {
        delegate?.logOutTapped()
    }
    
    @IBAction func yourRoutesTapped(_ sender: Any) {
        delegate?.userRoutesTapped()
    }
    
    @IBAction func reservedRoutesTapped(_ sender: Any) {
        delegate?.reservedRoutesTapped()
    }
}
