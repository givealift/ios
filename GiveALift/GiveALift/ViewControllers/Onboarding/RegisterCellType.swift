//
//  RegisterCellType.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 27.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

enum CellType {
    case textfield
}

protocol RegisterCellType {
    var labelText: String { get }
    var validationRule: ValidatorRule { get }
    var type: CellType { get }
}

struct EmailCell: RegisterCellType {
    var labelText: String = "Podaj emial"
    var validationRule: ValidatorRule {
        var rule = ValidatorRulePattern(pattern: .email)
        rule.set(errorMessage: "Podany emial jest niewłaciwy")
        return rule
    }
    var type: CellType = .textfield
}
