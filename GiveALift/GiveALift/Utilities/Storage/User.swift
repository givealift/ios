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
    
    private let storage = LocalStorageManager(userDefaults: UserDefaults.standard)
    
    func logIn(user: Response) {
        storage.setToken(user.authToken.token)
        isLogIn = true
    }
}
