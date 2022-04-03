//
//  ProductListResult.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 30.03.2022.
//

import Foundation

struct ProductListResult: Codable {
     let productId: Int?
     let productName: String?
     let price: Int?

     enum CodingKeys: String, CodingKey {
         case productId = "id_product"
         case productName = "product_name"
         case price
     }
 }
