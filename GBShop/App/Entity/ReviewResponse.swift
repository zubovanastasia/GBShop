//
//  ReviewResponse.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 12.04.2022.
//

import Foundation

struct ReviewResponse: Codable {
    let userId: Int?
    let userName: String?
    let reviewText: String?
}
