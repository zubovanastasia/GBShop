//
//  ProductListRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 30.03.2022.
//

import Foundation
import Alamofire

protocol CatalogRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[CatalogResponse]>) -> Void)
}
