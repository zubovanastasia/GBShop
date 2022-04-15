//
//  BasketResponse.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 15.04.2022.
//

import Foundation

struct BasketResponse: Codable {
    var amount: Int?
    var count: Int?
    var contents: [BasketContents]
}

struct BasketContents: Codable {
    var productId: Int?
    var productName: String?
    var productPrice: Int?
    var quantity: Int?
}
