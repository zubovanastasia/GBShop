//
//  User.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 24.03.2022.
//

import Foundation
import Realm
import RealmSwift

final class User: Object, Codable {
    let id: Int?
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    let email: String?
    let gender: String?
    let creditCard: String?
    let bio: String?
    let name: String?
    let lastname: String?
    
    convenience init(login: String, password: String, email: String) {
        self.init()
        self.login = login
        self.password = password
    }
    init (id: Int? = nil, login: String, password: String, email: String? = nil, gender: String? = nil, creditCard: String? = nil, bio: String? = nil, name: String? = nil, lastname: String? = nil) {
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
final class UserObject: Object {
    let users = List<User>()
}
