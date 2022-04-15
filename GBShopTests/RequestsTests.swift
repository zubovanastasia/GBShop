//
//  RequestsTests.swift
//  GBShopTests
//
//  Created by Anastasiia Zubova on 30.03.2022.
//

import XCTest
@testable import GBShop

class RequestsTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Perform request.")
    let timeoutValue = 10.0
    var requestFactory: RequestFactory!
    var user: User!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        requestFactory = RequestFactory()
        user = User(login: "UserOne",
                    password: "123",
                    email: "userone@mail.ru",
                    gender: "m",
                    creditCard: "5344-5764-3634-5674-4574",
                    bio: "-",
                    name: "Ben",
                    lastname: "Mel")
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        requestFactory = nil
        user = nil
    }

     func testShouldPerformSignupRequest() {
         let factory = requestFactory.makeSignUpRequestFactory()
         factory.signUp(user: user) { response in
             switch response.result {
             case .success(let result): XCTAssertEqual(result.result, 1)
             case .failure: XCTFail()
             }
             self.expectation.fulfill()
         }
         wait(for: [expectation], timeout: timeoutValue)
     }

     func testShouldPerformAuthRequest() {
         let factory = requestFactory.makeAuthRequestFactory()
         factory.login(user: user) { response in
             switch response.result {
             case .success(let result): XCTAssertEqual(result.result, 1)
             case .failure: XCTFail()
             }
             self.expectation.fulfill()
         }
         wait(for: [expectation], timeout: timeoutValue)
     }

     func testShouldPerformChangePersonalDataRequest() {
         let factory = requestFactory.makeChangePersonalDataRequestFactory()
         factory.changePersonalData(user: user) { response in
             switch response.result {
             case .success(let result): XCTAssertEqual(result.result, 1)
             case .failure: XCTFail()
             }
             self.expectation.fulfill()
         }
         wait(for: [expectation], timeout: timeoutValue)
     }

     func testShouldPerformLogoutRequest() {
         let factory = requestFactory.makeLogoutRequestFactory()
         factory.logout(user: user) { response in
             switch response.result {
             case .success(let result): XCTAssertEqual(result.result, 1)
             case .failure: XCTFail()
             }
             self.expectation.fulfill()
         }
         wait(for: [expectation], timeout: timeoutValue)
     }

     func testShouldPerformGetCatalogRequest() {
         let factory = requestFactory.makeProductListRequestFactory()
         factory.productList(pageNumber: 1, categoryId: 1) { response in
             switch response.result {
             case .success: break
             case .failure: XCTFail()
             }
             self.expectation.fulfill()
         }
         wait(for: [expectation], timeout: timeoutValue)
     }

     func testShouldPerformGetGoodRequest() {
         let factory = requestFactory.makeGetGoodRequestFactory()
         factory.getGood(productId: 123) { response in
             switch response.result {
             case .success(let result): XCTAssertEqual(result.result, 1)
             case .failure: XCTFail()
             }
             self.expectation.fulfill()
         }
         wait(for: [expectation], timeout: timeoutValue)
     }
 }
