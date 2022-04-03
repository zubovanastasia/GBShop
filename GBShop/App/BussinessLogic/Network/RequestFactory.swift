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
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser,
                    sessionManager: commonSession,
                    queue: sessionQueue)
    }
    
    func makeSignUpRequestFactory() -> SignUpRequestFactory {
        let errorParser = makeErrorParser()
        return SignUp(errorParser: errorParser,
                      sessionManager: commonSession,
                      queue: sessionQueue)
    }
    
    func makeChangePersonalDataRequestFactory() -> ChangePersonalDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangePersonalData(errorParser: errorParser,
                                  sessionManager: commonSession,
                                  queue: sessionQueue)
    }
    
    func makeLogoutRequestFactory() -> LogoutRequestFactory {
        let errorParser = makeErrorParser()
        return Logout(errorParser: errorParser,
                      sessionManager: commonSession,
                      queue: sessionQueue)
    }
    func makeProductListRequestFactory() -> ProductListRequestFactory {
        let errorParser = makeErrorParser()
        return ProductList(errorParser: errorParser,
                           sessionManager: commonSession,
                           queue: sessionQueue)
    }
    
    func makeGoodByIdRequestFactory() -> GoodByIdRequestFactory {
        let errorParser = makeErrorParser()
        return GoodById(errorParser: errorParser,
                        sessionManager: commonSession,
                        queue: sessionQueue)
    }
}
