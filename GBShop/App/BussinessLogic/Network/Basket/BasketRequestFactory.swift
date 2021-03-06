//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 15.04.2022.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    func getBasket(user: User, completionHandler: @escaping (AFDataResponse<BasketResponse>) -> Void)
    func payBasket(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    func addToBasket(basket: BasketUser, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    func deleteFromBasket(basket: BasketUser, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}
