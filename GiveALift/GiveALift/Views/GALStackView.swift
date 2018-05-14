//
//  GALStackView.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class GALView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBackground()
    }
    
    func setupBackground() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 15
    }
    
}
