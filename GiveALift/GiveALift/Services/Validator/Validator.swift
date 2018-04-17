//
//  Validator .swift
//  CountIn
//
//  Created by Marcin Włoczko on 30.10.2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

/*
 Przykład użycia
 let word = "text"
 let lengthRule = ValidatorRuleLenth(rule: .maximumLength, value: 69)
 let email = ValidatorRulePattern(pattern: .email)
 let result = word.validated(rules: [lengthRule, email])
 switch result {
    case invalid(let error):
 print("porawny")
    case valid:
 print("niepopwarny")
 }
 */

enum Result {
    case invalid(error: String)
    case valid
}

enum Rule {
    case maximumLength
    case minimumLength
    
    var errorMessage: String {
        switch self {
        case .maximumLength:
            return "Word is too long"
        case .minimumLength:
            return "Word is too short"
        }
    }
}

enum Pattern: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case phoneNumber = "[0-9]{9}"
    case customString
    
    var errorMessage: String {
        switch self {
        case .email:
            return "Incorrect email"
        case .phoneNumber:
            return "Incorrect phone number"
        case .customString:
            return "Strings don't match"
        }
    }
}

protocol ValidatorRule {
    var errorMessage: String { get set }
    func check(string: String) -> Result
}

extension ValidatorRule {
    mutating func set(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

final class ValidatorRuleLength: ValidatorRule {
    
    var errorMessage: String
    let value: Int
    let rule: Rule
    
    init(rule: Rule, value: Int) {
        self.value = value
        self.rule = rule
        errorMessage = rule.errorMessage
    }
    
    func check(string: String) -> Result {
        var result: Result
        switch self.rule {
        case .maximumLength:
            result = string.characters.count > self.value ? Result.invalid(error: errorMessage) : Result.valid
        case .minimumLength:
            result = string.characters.count < self.value ? Result.invalid(error: errorMessage) : Result.valid
        }
        return result
    }
}

final class ValidatorRulePattern: ValidatorRule {
    
    var errorMessage: String
    let pattern: Pattern
    let dynamicString: (() -> String)?
    
    init(pattern: Pattern) {
        self.pattern = pattern
        self.errorMessage = pattern.errorMessage
        self.dynamicString = nil
    }
    
    init(dynamicString: @escaping () -> String) {
        self.pattern = .customString
        self.errorMessage = pattern.errorMessage
        self.dynamicString = dynamicString
    }
    
    func check(string: String) -> Result {
        if let dynamicString = dynamicString {
            return string == dynamicString() ? Result.valid : Result.invalid(error: errorMessage)
        }
        let pattern = self.pattern.rawValue
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: string) ? Result.valid : Result.invalid(error: errorMessage)
    }
}

extension String {
    
    func validated(with rule: ValidatorRule) -> Result {
        return rule.check(string: self)
    }
    
    func validated(with rules: [ValidatorRule]) -> [Result] {
        var results = [Result]()
        for rule in rules {
            results.append(rule.check(string: self))
        }
        return results
    }
}

