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
        static let userID = "userID"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let phoneNumber = "phoneNumber"
        static let gender = "gender"
        static let email = "email"
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
    
    func setUserID(_ value: Int) {
        userDefaults.set(value, forKey: LocalStorageKeys.userID)
    }
    
    func getUserID() -> Int? {
        return userDefaults.value(forKey: LocalStorageKeys.userID) as? Int
    }
    
    func setUserFirstName(_ value: String) {
        userDefaults.set(value, forKey: LocalStorageKeys.firstName)
    }
    
    func getFirstName() -> String? {
        return userDefaults.value(forKey: LocalStorageKeys.firstName) as? String
    }
    
    func setUserLastName(_ value: String) {
        userDefaults.set(value, forKey: LocalStorageKeys.lastName)
    }
    
    func getLastName() -> String? {
        return userDefaults.value(forKey: LocalStorageKeys.lastName) as? String
    }
    
    func setPhoneNumber(_ value: String) {
        userDefaults.set(value, forKey: LocalStorageKeys.phoneNumber)
    }
    
    func getPhoneNumber() -> String? {
        return userDefaults.value(forKey: LocalStorageKeys.phoneNumber) as? String
    }
    
    func setGender(_ value: String) {
        userDefaults.set(value, forKey: LocalStorageKeys.gender)
    }
    
    func getGender() -> String? {
        return userDefaults.value(forKey: LocalStorageKeys.gender) as? String
    }
    
    func setEmail(_ value: String) {
        userDefaults.set(value, forKey: LocalStorageKeys.email)
    }
    
    func getEmail() -> String? {
        return userDefaults.value(forKey: LocalStorageKeys.email) as? String
    }
    
    func removeAllData() {
        guard let appDomain = Bundle.main.bundleIdentifier else { return }
        userDefaults.removePersistentDomain(forName: appDomain)
    }
    
}
