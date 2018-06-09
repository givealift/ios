//
//  ErrorMessage.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 22.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class ErrorMessage: UIView {

    //MARK:- IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK:- VC's life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK:- Main
    func setErrorMessage(_ message: String) {
        errorLabel.text = message
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("ErrorMessage", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
