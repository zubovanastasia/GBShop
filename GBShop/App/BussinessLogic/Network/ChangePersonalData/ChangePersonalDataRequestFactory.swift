//
//  ChangePersonalDataRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 25.03.2022.
//

import Foundation
import Alamofire

protocol ChangePersonalDataRequestFactory {
    func changePersonalData(user: User, completionHandler: @escaping (AFDataResponse<ChangePersonalDataResult>) -> Void)
}
