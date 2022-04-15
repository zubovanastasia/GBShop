//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 12.04.2022.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory {
    func getReviews(productId: Int, completionHandler: @escaping (AFDataResponse<[ReviewResponse]>) -> Void)
    func addReview(review: AddReviewResponse, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    func removeReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}
