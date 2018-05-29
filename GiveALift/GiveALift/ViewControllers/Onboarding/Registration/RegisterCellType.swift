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
    case segController
}

protocol RegisterCellType {
    var labelText: String { get }
    var validationRule: ValidatorRule { get }
    var type: CellType { get }
    var value: String? { get set }
    var secure: Bool { get }
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
    var secure: Bool = false
    
    var labelText: String = "Email"
    var validationRule: ValidatorRule {
        var rule = ValidatorRulePattern(pattern: .email)
        rule.set(errorMessage: "Podany emial jest niewłaciwy")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

class PasswordCell: RegisterCellType {
    var secure: Bool = true
    var labelText: String = "Hasło"
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
    var secure: Bool = true
    var labelText: String = "Potwierdź hasło"
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
    var secure: Bool = false
    var labelText: String = "Imię"
    var validationRule: ValidatorRule {
        var rule = ValidatorRuleLength(rule: .maximumLength, value: 25)
        rule.set(errorMessage: "Podane imię jest zbyt długie")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

class SurnameCell: RegisterCellType {
    var secure: Bool = false
    var labelText: String = "Nazwisko"
    var validationRule: ValidatorRule {
        var rule = ValidatorRuleLength(rule: .maximumLength, value: 25)
        rule.set(errorMessage: "Podane nazwisko jest zbyt długie")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

class PhoneNumberCell: RegisterCellType {
    var secure: Bool = false
    var labelText: String = "Numer telefonu"
    var validationRule: ValidatorRule {
        var rule = ValidatorRulePattern(pattern: .phoneNumber)
        rule.set(errorMessage: "Podany numer jest nieporawny")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

class BirthdayCell: RegisterCellType {
    var secure: Bool = false
    var labelText: String = "Data urodzenia"
    var validationRule: ValidatorRule {
        var rule = ValidatorRulePattern(pattern: .phoneNumber)
        rule.set(errorMessage: "Data urodzenia źle ")
        return rule
    }
    var type: CellType = .textfield
    var value: String? = nil
}

enum Gender: String {
    case man = "male"
    case woman = "female"
}

class GenderCell: RegisterCellType {
    var secure: Bool = false
    var labelText: String = ""
    var validationRule: ValidatorRule {
        return ValidatorRulePattern(pattern: .phoneNumber)
    }
    var type: CellType = .segController
    var value: String?
    var gender: Gender = .woman
}
