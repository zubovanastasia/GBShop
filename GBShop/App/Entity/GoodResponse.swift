//
//  GoodByIdResponse.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 12.04.2022.
//

import Foundation

struct GoodResponse: Codable {
    let result: Int?
    let productName: String?
    let productId: Int?
    let price: Int?
    let description: String?
    let imageProduct: String?
    let review: [ReviewResponse]?
}
