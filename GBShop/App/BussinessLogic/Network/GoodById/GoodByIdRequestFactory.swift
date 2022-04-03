//
//  GoodByIdRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 01.04.2022.
//

import Foundation
import Alamofire

protocol GoodByIdRequestFactory {
    func goodById(productId: Int, completionHandler: @escaping (AFDataResponse<GoodByIdResult>) -> Void)
}
