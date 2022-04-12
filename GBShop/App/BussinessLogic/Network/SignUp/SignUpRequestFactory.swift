//
//  SignUpRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 25.03.2022.
//

import Foundation
import Alamofire

protocol SignupRequestFactory {
    func signup(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}
