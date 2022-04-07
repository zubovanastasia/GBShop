//
//  ProductList.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 30.03.2022.
//

import Foundation
import Alamofire

class ProductList: AbstractRequestFactory {
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

extension ProductList: ProductListRequestFactory {
    func productList(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[ProductListResult]>) -> Void) {
        let requestModel = ProductList(baseUrl: baseUrl,
                                       pageNumber: pageNumber,
                                       categoryId: categoryId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductList {
    struct ProductList: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        let pageNumber: Int
        let categoryId: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryId
            ]
        }
    }
}
