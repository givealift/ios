//
//  GALTextField.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class GALTextField: UITextField {
    
    var rule: ValidatorRule?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBottomLine(borderColor: .black)
        setupFont()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBottomLine(borderColor: .black)
        setupFont()
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
    
    func isValid() -> ValidationResult {
        guard let text = self.text, text != "" else { return ValidationResult.invalid(error: "Wszystkie pola muszą zostać uzupełnione") }
        guard let rule = self.rule else { return ValidationResult.valid }
        return text.validated(with: rule)
    }
    
    private func setupFont() {
        self.font = UIFont.systemFont(ofSize: 14)
    }
}
