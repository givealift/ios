//
//  UserTests.swift
//  GiveALiftTests
//
//  Created by Marcin Włoczko on 09.06.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import XCTest
@testable import GiveALift

class UserTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
    }
    
    func testUser() {
        let userInfo = GALUserInfo(address: "address", birthYear: Date(), email: "mwloczko@gmail.com", firstName: "imie", lastName: "naziwkso", gender: "male", phone: "1231141", rate: 0, password: "kast")
        let userID = GALUserLogin(userID: 2, token: "token")
        User.shared.logIn(user: userID, userInfo: userInfo)
        XCTAssertEqual(userInfo.email, User.shared.email)
        XCTAssertEqual(userInfo.birthYear, User.shared.birthDay)
        XCTAssertEqual(userID.userID, User.shared.userID)
        User.shared.logOut()
        XCTAssertNotEqual(userInfo.email, User.shared.email)
        XCTAssertNotEqual(userInfo.birthYear, User.shared.birthDay)
        XCTAssertNotEqual(userID.userID, User.shared.userID)
        XCTAssertNil(User.shared.email)
        XCTAssertNil(User.shared.birthDay)
        XCTAssertNil(User.shared.userID)
    }
    
}
