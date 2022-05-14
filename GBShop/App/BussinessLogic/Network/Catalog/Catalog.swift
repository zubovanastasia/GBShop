//
//  ProductList.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 30.03.2022.
//

import Foundation
import Alamofire

class Catalog: AbstractRequestFactory {
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

extension Catalog: CatalogRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[CatalogResponse]>) -> Void) {
        let requestModel = Catalog(baseUrl: baseUrl,
                                   pageNumber: pageNumber,
                                   categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Catalog {
    struct Catalog: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getcatalog"
        let pageNumber: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "pageNumber": pageNumber,
                "categoryId": categoryId
            ]
        }
    }
}
