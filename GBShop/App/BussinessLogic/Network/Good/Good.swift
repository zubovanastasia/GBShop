//
//  GoodById.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 01.04.2022.
//

import Foundation
import Alamofire

class Good: AbstractRequestFactory {
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

extension Good: GoodRequestFactory {
    func getGood(productId: Int, completionHandler: @escaping (AFDataResponse<GoodResponse>) -> Void) {
        let requestModel = Good(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Good {
    struct Good: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getgood"
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}
