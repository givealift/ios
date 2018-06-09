//
//  LabelTableViewCell.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 09.06.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with text: String) {
        label.text = text
    }
    
}
