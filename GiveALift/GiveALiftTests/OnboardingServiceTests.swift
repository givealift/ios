//
//  OnboardingServiceTests.swift
//  GiveALiftTests
//
//  Created by Marcin Włoczko on 31.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import XCTest
@testable import GiveALift

class OnboardingServiceTests: XCTestCase, OnboardingServiceRegisterDelegate {
    
    private var numbersExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRegistration() {
        let onboarginService = OnboardingService()
        onboarginService.registerDelegate = self
        let request = RegisterRequest(address: "bezdomny", birthYear: Date(), email: "mwloczko@gmail.com", firstName: "Marcin", gender: "male", lastName: "Włoczko", password: "wloczkoo", phone: "123456789", rate: 0)
        onboarginService.register(request: request)
    }
    
    func onboardingService(status: Bool) {
        numbersExpectation.fulfill()
    }
    
    func onboardingService(error: APIError) {
        numbersExpectation.fulfill()
    }
}
