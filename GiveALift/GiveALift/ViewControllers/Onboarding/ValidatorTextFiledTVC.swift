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
        setupTextField()
        label.isHidden = true
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        cellType.value = text
        let result = text.validated(with: cellType.validationRule)
        switch result {
        case .valid:
            self.label.isHidden = true
            self.label.text = nil
        case .invalid(error: let error):
            self.label.isHidden = false
            self.label.text = error
        }
    }
    
    private func setupTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(ValidatorTextFiledTVC.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        if let text = cellType.value {
            setupBlackTextfield(withText: text)
        } else {
            setupGrayTextfield(withText: cellType.labelText)
        }
    }
    
    private func setupGrayTextfield(withText text: String) {
        textField.textColor = UIColor.lightGray
        textField.text = text
    }
    
    private func setupBlackTextfield(withText text: String?) {
        textField.textColor = UIColor.black
        textField.text = text
    }
}

extension ValidatorTextFiledTVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupBlackTextfield(withText: cellType.value)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        cellType.value = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
