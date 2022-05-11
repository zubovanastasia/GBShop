//
//  BasketSingle.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 10.05.2022.
//

import Foundation

class BasketSingle {
    static let shared = BasketSingle()
    init(){}
    var items: [BasketSingleItem] = []
}

struct BasketSingleItem {
    let productId: Int?
    let productName: String?
    let productPrice: Int?
    let imageProduct: String?
}
