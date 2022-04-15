//
//  Basket.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 15.04.2022.
//

import Foundation
import Alamofire

class Basket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://afternoon-hollows-69135.herokuapp.com/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Basket: BasketRequestFactory {
    func getBasket(user: User, completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void) {
        let requestModel = GetBasket(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func payBasket(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = PayBasket(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func addToBasket(basket: BasketUser, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = AddToBasket(baseUrl: baseUrl, basket: basket)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func deleteFromBasket(basket: BasketUser, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = DeleteFromBasket(baseUrl: baseUrl, basket: basket)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Basket {
    struct GetBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getbasket"
        let user: User
        var parameters: Parameters? {
            return ["id": user.id ?? 0]
        }
    }
    struct PayBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "paybasket"
        let user: User
        var parameters: Parameters? {
            return ["id": user.id ?? 0]
        }
    }
    struct AddToBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addtobasket"
        let basket: BasketUser
        var parameters: Parameters? {
            return ["productId": basket.productId ?? 0,
                    "quantity": basket.quantity ?? 0]
        }
    }
    struct DeleteFromBasket: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deletefrombasket"
        let basket: BasketUser
        var parameters: Parameters? {
            return ["productId": basket.productId ?? 0]
        }
    }
}
