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
        let factory = requestFactory.makeSignupRequestFactory()
        factory.signup(user: user) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    func testShouldPerformAuthRequest() {
        let factory = requestFactory.makeLoginRequestFactory()
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
        let factory = requestFactory.makeChangeUserDataRequestFactory()
        factory.changeUserData(user: user) { response in
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
        let factory = requestFactory.makeCatalogRequestFactory()
        factory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success: break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    func testShouldPerformGetGoodRequest() {
        let factory = requestFactory.makeGoodRequestFactory()
        factory.getGood(productId: 123) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    func testShouldPerformGetReviewsRequest() {
        let factory = requestFactory.makeReviewsRequestFactory()
        factory.getReviews(productId: 123) { response in
            switch response.result {
            case .success(let result): XCTAssertGreaterThan(result.count, 0)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    func testShouldPerformAddReviewsRequest() {
        let factory = requestFactory.makeReviewsRequestFactory()
        factory.addReview(review: AddReviewResponse(reviewText: "Прекрасный товар!", userId: 123, productId: 456)) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    func testShouldPerformRemoveReviewsRequest() {
        let factory = requestFactory.makeReviewsRequestFactory()
        factory.removeReview(reviewId: 123) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    func testShouldPerformGetBasketRequest() {
        let factory = requestFactory.makeBasketRequestFactory()
        factory.getBasket(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result): XCTAssertNotNil(result.count)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    func testShouldPerformPayBasketRequest() {
        let factory = requestFactory.makeBasketRequestFactory()
        factory.payBasket(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    func testShouldPerformAddToBasketRequest() {
        let factory = requestFactory.makeBasketRequestFactory()
        factory.addToBasket(basket: BasketUser(productId: 456, quantity: 1)){ response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    func testShouldPerformDeleteFromBasketRequest() {
        let factory = requestFactory.makeBasketRequestFactory()
        factory.deleteFromBasket(basket: BasketUser(productId: 456)){ response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
}
