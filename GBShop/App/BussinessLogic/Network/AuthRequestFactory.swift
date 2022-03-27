//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 24.03.2022.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(user: User, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
