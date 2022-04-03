//
//  ProductListRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 30.03.2022.
//

import Foundation
import Alamofire

protocol ProductListRequestFactory {
    func productList(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[ProductListResult]>) -> Void)
}
