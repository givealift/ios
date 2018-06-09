//
//  Result.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case Error(error : APIError)
    case Success(result : T)
}

typealias APIResultBlock<T> = (APIResult<T>) -> ()

enum APIError: CustomStringConvertible, Error {
    case unexpectedError
    case noData
    case wrongHTTPCode(code: Int )
    case jsonSerializationFailed
    
    var description: String {
        switch self {
        case .unexpectedError:
            return NSLocalizedString("Brak połączenia internetowego", comment: "")
        case .noData:
            return NSLocalizedString("Brak poziomów - spróbuj później", comment: "")
        case .jsonSerializationFailed :
            return NSLocalizedString("Błąd aplikacji - spróbuj później", comment: "")
        case .wrongHTTPCode(code: let code):
            return NSLocalizedString("Bład numer: \(code)", comment: "")
        }
    }
}
