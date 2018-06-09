//
//  LocalStorageTests.swift
//  GiveALiftUITests
//
//  Created by Marcin Włoczko on 09.06.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import XCTest
@testable import GiveALift

class LocalStorageTests: XCTestCase {
    
    private var localStorage: LocalStorageManager!
    private let suitName = "UnitTestUserDefaults"
    private lazy var userDefaults: UserDefaults = {
        return UserDefaults(suiteName: suitName)!
    }()
    
    override func setUp() {
        super.setUp()
        localStorage = LocalStorageManager(userDefaults: userDefaults)
        userDefaults.removePersistentDomain(forName: suitName)
    }
    
    override func tearDown() {
        userDefaults.removePersistentDomain(forName: suitName)
        localStorage = nil
        super.tearDown()
    }
    
    func testToken() {
        let token = "dsdadada"
        localStorage.setToken(token)
        XCTAssertEqual(token, localStorage.getToken())
    }
    
    func testMail() {
        let mail = "mwlocz@gmail.com"
        localStorage.setEmail(mail)
        XCTAssertEqual(mail, localStorage.getEmail())
    }
    
    func testBirthday() {
        let birth = Date()
        localStorage.setBirthday(birth)
        XCTAssertEqual(birth, localStorage.getBirthDay())
    }
    
    func testUserID() {
        let userID = 13
        localStorage.setUserID(userID)
        XCTAssertEqual(userID, localStorage.getUserID())
    }
}
