//
//  GBShopViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 25.03.2022.
//

import Foundation
import UIKit

class GBShopViewController: UIViewController {
    
    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeAuthRequest()
        makeSignUpRequest()
        makeChangeUserDataRequest()
        makeLogoutRequest()
    }
    
    // MARK: - Test functions.
    
    func makeAuthRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(login: "User", password: "123")
        
        factory.login(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeSignUpRequest() {
        let factory = requestFactory.makeSignUpRequestFactory()
        let user = User(login: "UserOne",
                        password: "123",
                        email: "userone@mail.ru",
                        gender: "m",
                        creditCard: "5344-5764-3634-5674-4574",
                        bio: "-",
                        name: "Ben",
                        lastname: "Mel")
        
        factory.signUp(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeChangeUserDataRequest() {
        let factory = requestFactory.makeChangePersonalDataRequestFactory()
        let user = User(id: 123,
                        login: "UserOne",
                        password: "123",
                        email: "userone@mail.ru",
                        gender: "m",
                        creditCard: "5344-5764-3634-5674-4574",
                        bio: "-",
                        name: "Ben",
                        lastname: "Mel")
        
        factory.changePersonalData(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeLogoutRequest() {
        let factory = requestFactory.makeLogoutRequestFactory()
        let user = User(id: 123)
        
        factory.logout(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
