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
    var value: String? { get set }
}

extension RegisterCellType {
    func isValid() -> Bool {
        if let value = value {
            let result = value.validated(with: validationRule)
            switch result {
            case .invalid(error: _):
                return false
            case .valid:
                return true
            }
        }
        return false
    }
}

class EmailCell: RegisterCellType {
    var labelText: String = "Podaj emial"
    var validationRule: ValidatorRule {
        var rule = ValidatorRulePattern(pattern: .email)
        rule.set(errorMessage: "Podany emial jest niewłaciwy")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

class PasswordCell: RegisterCellType {
    var labelText: String = "Podaj hasło"
    var validationRule: ValidatorRule {
        var rule = ValidatorRuleLength(rule: .minimumLength, value: 8)
        rule.set(errorMessage: "Hasło musi zawierać co najmniej 8 znaków")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

//MARK:- TODO validation rule do takich samych haseł
class CompatibilePasswordCell: RegisterCellType {
    var labelText: String = "Powtórz hasło"
    var validationRule: ValidatorRule {
        var rule = ValidatorRulePattern(dynamicString: { return self.passwordCell?.value ?? ""})
        rule.set(errorMessage: "Hasła muszą być zgodne")
        return rule
    }
    var passwordCell: PasswordCell?
    var type: CellType = .textfield
    var value: String? = nil
}

class NameCell: RegisterCellType {
    var labelText: String = "Podaj imię"
    var validationRule: ValidatorRule {
        var rule = ValidatorRuleLength(rule: .maximumLength, value: 25)
        rule.set(errorMessage: "Podane imię jest zbyt długie")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

class SurnameCell: RegisterCellType {
    var labelText: String = "Podaj nazwisko"
    var validationRule: ValidatorRule {
        var rule = ValidatorRuleLength(rule: .maximumLength, value: 25)
        rule.set(errorMessage: "Podane nazwisko jest zbyt długie")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

class PhoneNumberCell: RegisterCellType {
    var labelText: String = "Podaj numer telefonu"
    var validationRule: ValidatorRule {
        var rule = ValidatorRulePattern(pattern: .phoneNumber)
        rule.set(errorMessage: "Podany numer jest nieporawny")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}
