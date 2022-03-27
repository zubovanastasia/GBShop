//
//  SignUpRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 25.03.2022.
//

import Foundation
import Alamofire

protocol SignUpRequestFactory {
    func signUp(user: User, completionHandler: @escaping (AFDataResponse<SignUpResult>) -> Void)
}
