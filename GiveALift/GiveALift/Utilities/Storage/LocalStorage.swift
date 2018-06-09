//
//  LocalStorageManager.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol LocalStorage {
    func setToken(_ value: String)
    func getToken() -> String?
}
