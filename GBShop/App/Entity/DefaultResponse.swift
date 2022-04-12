//
//  DefaultResponse.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 12.04.2022.
//

import Foundation

struct DefaultResponse: Codable {
    var result: Int
    var successMessage: String?
    var errorMessage: String?
}
