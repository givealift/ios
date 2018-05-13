//
//  SegControllerTableViewCell.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class SegControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var segController: UISegmentedControl!
    private var genderCell: GenderCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(genderCell: GenderCell) {
        self.genderCell = genderCell
    }
    
    @IBAction func segChange(_ sender: Any) {
        genderCell.gender = segController.selectedSegmentIndex == 0 ? .woman : .man
    }
}
