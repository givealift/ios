//
//  User.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class User {
    
    static let shared = User()
    var isLogIn = false 
    var token: String? {
        return storage.getToken()
    }
    var userID: Int? {
        return storage.getUserID()
    }
    var gender: String? {
        return storage.getGender()
    }
    var firstName: String? {
        return storage.getFirstName()
    }
    var lastName: String? {
        return storage.getLastName()
    }
    var phoneNumber: String? {
        return storage.getPhoneNumber()
    }
    var email: String? {
        return storage.getEmail()
    }
    var rate: Int? {
        return storage.getRate()
    }
    var birthDay: Date? {
        return storage.getBirthDay()
    }
    
    private let storage = LocalStorageManager(userDefaults: UserDefaults.standard)
    
    func logIn(user: GALUserLogin, userInfo: GALUserInfo) {
        storage.setToken(user.token)
        print("USEEEEEER IDDDDD")
        print(user.userID)
        storage.setUserID(user.userID)
        storage.setEmail(userInfo.email!)
        storage.setPhoneNumber(userInfo.phone!)
        storage.setUserLastName(userInfo.lastName!)
        storage.setUserFirstName(userInfo.firstName!)
        storage.setGender("male")
        storage.setRate(userInfo.rate!)
        storage.setBirthday(userInfo.birthYear!)
        isLogIn = true
    }
    
    func logOut() {
        storage.removeAllData()
        isLogIn = false
    }
}
