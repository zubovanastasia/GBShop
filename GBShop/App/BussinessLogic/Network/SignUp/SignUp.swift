//
//  SignUp.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 25.03.2022.
//

import Foundation
import Alamofire

class Signup: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://afternoon-hollows-69135.herokuapp.com/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Signup: SignupRequestFactory {
    func signup(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = Signup(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Signup {
    struct Signup: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "signup"
        let user: User
        var parameters: Parameters? {
            return [
                "id_user": user.id ?? 0,
                "username": user.login ?? "",
                "password": user.password ?? "",
                "email": user.email ?? "",
                "gender": user.gender ?? "",
                "credit_card": user.creditCard ?? "",
                "bio": user.bio ?? ""
            ]
        }
    }
}
