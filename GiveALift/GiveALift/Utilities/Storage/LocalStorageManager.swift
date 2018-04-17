//
//  LocalStorageManager.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class LocalStorageManager: LocalStorage {
    
    private let userDefaults: UserDefaults
    private enum LocalStorageKeys {
        static let token = "token"
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func setToken(_ value: String) {
        userDefaults.set(value, forKey: LocalStorageKeys.token)
    }
    
    func getToken() -> String? {
        return userDefaults.value(forKey: LocalStorageKeys.token) as? String
    }
    
    
}
