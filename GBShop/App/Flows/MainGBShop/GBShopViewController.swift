//
//  GBShopViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 25.03.2022.
//

import Foundation
import UIKit

class GBShopViewController: UIViewController {
    private let request = RequestFactory()
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        makeAuthRequest()
        makeSignupRequest()
        makeChangeUserDataRequest()
        makeCatalogRequest()
        makeGetGoodRequest()
        makeLogoutRequest()
        makeGetReviewsRequest()
        makeAddReviewRequest()
        makeRemoveReviewRequest()
        makeGetBasketRequest()
        makePayBasketRequest()
        makeAddToBasketRequest()
        makeDeleteFromBasketRequest()
    }
    // MARK: - Data requests.
    func makeAuthRequest() {
        let factory = request.makeLoginRequestFactory()
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
    func makeSignupRequest() {
        let factory = request.makeSignupRequestFactory()
        let user = User(login: "UserOne",
                        password: "123",
                        email: "userone@mail.ru",
                        gender: "m",
                        creditCard: "5344-5764-3634-5674-4574",
                        bio: "-",
                        name: "Ben",
                        lastname: "Mel")
        factory.signup(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeChangeUserDataRequest() {
        let factory = request.makeChangeUserDataRequestFactory()
        let user = User(id: 123,
                        login: "UserOne",
                        password: "123",
                        email: "userone@mail.ru",
                        gender: "m",
                        creditCard: "5344-5764-3634-5674-4574",
                        bio: "-",
                        name: "Ben",
                        lastname: "Mel")
        factory.changeUserData(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeLogoutRequest() {
        let factory = request.makeLogoutRequestFactory()
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
    // MARK: - Catalog requests.
    func makeCatalogRequest() {
        let factory = request.makeCatalogRequestFactory()
        factory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeGetGoodRequest() {
        let factory = request.makeGoodRequestFactory()
        factory.getGood(productId: 123) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - Reviews requests.
    func makeGetReviewsRequest() {
        let factory = request.makeReviewsRequestFactory()
        factory.getReviews(productId: 123) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeAddReviewRequest() {
        let factory = request.makeReviewsRequestFactory()
        let review = AddReviewResponse(reviewText: "Прекрасный товар!",
                                       userId: 123,
                                       productId: 456)
        factory.addReview(review: review){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeRemoveReviewRequest() {
        let factory = request.makeReviewsRequestFactory()
        factory.removeReview(reviewId: 123){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - Basket requests.
    func makeGetBasketRequest() {
        let factory = request.makeBasketRequestFactory()
        factory.getBasket(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makePayBasketRequest() {
        let factory = request.makeBasketRequestFactory()
        factory.payBasket(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeAddToBasketRequest() {
        let factory = request.makeBasketRequestFactory()
        let basket = BasketUser(productId: 456, quantity: 1)
        factory.addToBasket(basket: basket){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func makeDeleteFromBasketRequest() {
        let factory = request.makeBasketRequestFactory()
        let basket = BasketUser(productId: 456)
        factory.deleteFromBasket(basket: basket){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - Controller show methods.
    private func showSignup() {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? SignupViewController {
            self.present(viewController, animated: true)
        }
    }
    private func showLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? LoginViewController {
            self.present(viewController, animated: true)
        }
    }
    // MARK: - IBAction methods.
    @IBAction private func signupButton(_ sender: Any) {
        self.showSignup()
    }
    @IBAction private func loginButton(_ sender: Any) {
        self.showLogin()
    }
}
