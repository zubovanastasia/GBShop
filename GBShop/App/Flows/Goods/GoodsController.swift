//
//  GoodsController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 01.05.2022.
//

import Foundation
import UIKit

class GoodsController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageProduct: UIImageView!
    @IBOutlet private weak var nameProduct: UILabel!
    @IBOutlet private weak var descriptionProduct: UILabel!
    @IBOutlet private weak var priceProduct: UILabel!
    @IBOutlet private weak var nameReviewer: UILabel!
    @IBOutlet private weak var review: UILabel!
    let request = RequestFactory()
    var productId: Int?
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewGoods()
        setupViewReviews()
    }
    // MARK: - Setup methods.
    private func getProduct(completionHandler: @escaping (GoodResponse) -> Void) {
        guard let productId = productId else {
            return
        }
        let factory = request.makeGoodRequestFactory()
        factory.getGood(productId: productId) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func getUserReview(completionHandler: @escaping ([ReviewResponse]?) -> Void) {
        let factory = request.makeReviewsRequestFactory()
        factory.getReviews(productId: productId ?? 0) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupViewGoods() {
        getProduct { good in
            DispatchQueue.main.async {
                self.nameProduct.text = good.productName ?? "name"
                self.descriptionProduct.text = good.description ?? "description"
                if let itemPrice = good.price {
                    self.priceProduct.text = "\(String(itemPrice)) ₽"
                } else {
                    self.priceProduct.text = "price"
                }
                if let imageURL = good.imageProduct, let url = URL(string: imageURL) {
                    self.imageProduct.loadImageURL(url: url)
                }
            }
        }
    }
    private func setupViewReviews() {
        getUserReview { review in
            DispatchQueue.main.async {
                self.nameReviewer.text = "\(String(review!.count))"
                self.review.text = "\(String(review!.count))"
            }
        }
    }
    // MARK: - IBAction methods.
    @IBAction private func openDescription(_ sender: Any) {
    }
    @IBAction private func addToCart(_ sender: Any) {
    }
    @IBAction private func addToWishlist(_ sender: Any) {
    }
    @IBAction private func showAllReviews(_ sender: Any) {
    }
}
