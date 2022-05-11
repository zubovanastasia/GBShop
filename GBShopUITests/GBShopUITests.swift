//
//  GBShopUITests.swift
//  GBShopUITests
//
//  Created by Anastasiia Zubova on 22.03.2022.
//

import XCTest

class GBShopUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
    }
    func testSignUpMainVC() throws {
        let mainVC = app.otherElements["mainVC"]
        XCTAssertTrue(mainVC.exists)
        let signupButton = mainVC.buttons["signupMain"]
        XCTAssertTrue(signupButton.exists)
        signupButton.tap()
    
        let signupVC = app.otherElements["signupVC"]
        XCTAssertTrue(signupVC.waitForExistence(timeout: 3))
    }
    func testLoginMainVC() throws {
        let mainVC = app.otherElements["mainVC"]
        XCTAssertTrue(mainVC.exists)
        let authButton = mainVC.buttons["loginMain"]
        XCTAssertTrue(authButton.exists)
        authButton.tap()
        
        let loginVC = app.otherElements["loginVC"].firstMatch
        XCTAssertTrue(loginVC.waitForExistence(timeout: 3))
        let loginText = loginVC.textFields["login"].firstMatch
        XCTAssertTrue(loginText.exists)
        loginText.tap()
        loginText.typeText("")
        let passwordText = loginVC.textFields["password"].firstMatch
        XCTAssertTrue(passwordText.exists)
        passwordText.tap()
        passwordText.typeText("")
        let loginButton = loginVC.buttons["loginButton"].firstMatch
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()
        
        let catalogVC = app.otherElements["catalogVC"].firstMatch
        XCTAssertTrue(catalogVC.waitForExistence(timeout: 3))
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
