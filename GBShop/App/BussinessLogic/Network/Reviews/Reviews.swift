//
//  Review.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 12.04.2022.
//

import Foundation
import Alamofire

class Reviews: AbstractRequestFactory {
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

extension Reviews: ReviewRequestFactory {
    func getReviews(productId: Int, completionHandler: @escaping (AFDataResponse<[ReviewResponse]>) -> Void) {
        let requestModel = GetReviews(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func addReview(review: AddReviewResponse, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = AddReview(baseUrl: baseUrl, review: review)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func removeReview(reviewId: Int, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void) {
        let requestModel = RemoveReview(baseUrl: baseUrl, reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Reviews {
    struct GetReviews: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getreviews"
        let productId: Int
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
    struct AddReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addreview"
        let review: AddReviewResponse
        var parameters: Parameters? {
            return [
                "productId": review.productId ?? 0,
                "userId": review.userId ?? 0,
                "reviewText": review.reviewText ?? ""
            ]
        }
    }
    struct RemoveReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removereview"
        let reviewId: Int
        var parameters: Parameters? {
            return [
                "reviewId": reviewId
            ]
        }
    }
}
