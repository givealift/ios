//
//  Textfield+LabelTVCell.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 26.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class ValidatorTextFiledTVC: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private var cellType: RegisterCellType!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(cellType: RegisterCellType) {
        self.cellType = cellType
        
        textField.delegate = self
        textField.textColor = UIColor.lightGray
        textField.text = cellType.labelText
        textField.addTarget(self, action: #selector(ValidatorTextFiledTVC.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        label.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let result = textField.text?.validated(with: cellType.validationRule) else { return }
        switch result {
        case .valid:
            <#code#>
        case .invalid:
            label.isHidden = false
            
        }
    }
}

extension ValidatorTextFiledTVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
        textField.textColor = UIColor.black
    }
}
