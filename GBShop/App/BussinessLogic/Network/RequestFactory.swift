//
//  RequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 24.03.2022.
//

import Foundation
import Alamofire

class RequestFactory {
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    } ()
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    func makeLoginRequestFactory() -> LoginRequestFactory {
        let errorParser = makeErrorParser()
        return Login(errorParser: errorParser,
                     sessionManager: commonSession,
                     queue: sessionQueue)
    }
    func makeSignupRequestFactory() -> SignupRequestFactory {
        let errorParser = makeErrorParser()
        return Signup(errorParser: errorParser,
                      sessionManager: commonSession,
                      queue: sessionQueue)
    }
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(errorParser: errorParser,
                              sessionManager: commonSession,
                              queue: sessionQueue)
    }
    func makeLogoutRequestFactory() -> LogoutRequestFactory {
        let errorParser = makeErrorParser()
        return Logout(errorParser: errorParser,
                      sessionManager: commonSession,
                      queue: sessionQueue)
    }
    func makeCatalogRequestFactory() -> CatalogRequestFactory {
        let errorParser = makeErrorParser()
        return Catalog(errorParser: errorParser,
                       sessionManager: commonSession,
                       queue: sessionQueue)
    }
    func makeGoodRequestFactory() -> GoodRequestFactory {
        let errorParser = makeErrorParser()
        return Good(errorParser: errorParser,
                    sessionManager: commonSession,
                    queue: sessionQueue)
    }
    func makeReviewsRequestFactory() -> ReviewRequestFactory {
        let errorParser = makeErrorParser()
        return Reviews(errorParser: errorParser,
                       sessionManager: commonSession,
                       queue: sessionQueue)
    }
    func makeBasketRequestFactory() -> BasketRequestFactory {
        let errorParser = makeErrorParser()
        return Basket(errorParser: errorParser,
                      sessionManager: commonSession,
                      queue: sessionQueue)
    }
}
