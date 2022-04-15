//
//  AddReviewResponse.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 12.04.2022.
//

import Foundation

struct AddReviewResponse: Codable {
    let reviewText: String?
    let userId: Int?
    let productId: Int?
}
