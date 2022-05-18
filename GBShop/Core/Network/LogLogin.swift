//
//  LogLogin.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 13.05.2022.
//

import Foundation
import Firebase

class LogLogin {
    class func logLogin(name: String, key: String, value: String) {
        Analytics.logEvent(name, parameters: [key: value])
    }
}
