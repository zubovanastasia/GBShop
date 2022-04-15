//
//  GoodByIdRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 01.04.2022.
//

import Foundation
import Alamofire

protocol GoodRequestFactory {
    func getGood(productId: Int, completionHandler: @escaping (AFDataResponse<GoodResponse>) -> Void)
}
