//
//  GALTextField.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class GALTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBottomLine(borderColor: .black)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBottomLine(borderColor: .black)
    }
    
    func setBottomLine(borderColor: UIColor) {
        self.borderStyle = .none
        self.backgroundColor = .clear
        let borderLine = UIView()
        let height = 1.0
        let textFieldHeight = Double(self.frame.height)
        let width = self.frame.maxX - self.frame.minX
        borderLine.frame = CGRect(x: 0, y: textFieldHeight*0.85, width: Double(width), height: height)
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
}
