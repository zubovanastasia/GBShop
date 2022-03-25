//
//  User.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 24.03.2022.
//

import Foundation

struct User: Codable {
    let id: Int?
    let login: String?
    let password: String?
    let email: String?
    let gender: String?
    let creditCard: String?
    let bio: String?
    let name: String?
    let lastname: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case password
        case email
        case gender
        case creditCard = "credit_card"
        case bio
        case name = "user_name"
        case lastname = "user_lastname"
    }
    
    init (id: Int? = nil, login: String? = nil, password: String? = nil, email: String? = nil, gender: String? = nil, creditCard: String? = nil, bio: String? = nil, name: String? = nil, lastname: String? = nil) {
        self.id = id
        self.login = login
        self.password = password
        self.email = email
        self.gender = gender
        self.creditCard = creditCard
        self.bio = bio
        self.name = name
        self.lastname = lastname
    }
}
