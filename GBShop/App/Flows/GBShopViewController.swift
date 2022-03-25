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
    
    // MARK: - Test methods.
    
    func makeAuthRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(login: "Somebody", password: "mypassword")
        
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
        let user = User(login: "SomebodyElse",
                        password: "mypassword",
                        email: "janedoe@gmail.com",
                        gender: "f",
                        creditCard: "2344-4324-2344-1233-1234",
                        bio: "Nothin to tell ya folks %)",
                        name: "Jane",
                        lastname: "Doe")
        
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
                        login: "SomebodyElse",
                        password: "mypassword",
                        email: "janedoe@gmail.com",
                        gender: "f",
                        creditCard: "2344-4324-2344-1233-1234",
                        bio: "Nothin to tell ya folks %)",
                        name: "Jane",
                        lastname: "Doe")
        
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
