//
//  GoodByIdResult.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 01.04.2022.
//

import Foundation

struct GoodByIdResult: Codable {
    let result: Int?
    let name: String?
    let price: Int?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}
