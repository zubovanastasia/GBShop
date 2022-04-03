//
//  GoodById.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 01.04.2022.
//

import Foundation
import Alamofire

class GoodById: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GoodById: GoodByIdRequestFactory {
    func goodById(productId: Int, completionHandler: @escaping (AFDataResponse<GoodByIdResult>) -> Void) {
        let requestModel = GoodById(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension GoodById {
    struct GoodById: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}
