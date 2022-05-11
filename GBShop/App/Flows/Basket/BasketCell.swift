//
//  BasketCell.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 10.05.2022.
//

import Foundation
import UIKit

class BasketCell: UITableViewCell {
    @IBOutlet private weak var imageProduct: UIImageView!
    @IBOutlet private weak var nameProduct: UILabel!
    @IBOutlet private weak var priceProduct: UILabel!
    var delegate: BasketDelegate?
    var row: Int?
    
    // MARK: - Configure method.
    func configure(_ item: BasketSingleItem) {
        nameProduct.text = item.productName
        if let itemPrice = item.productPrice {
            priceProduct.text = "\(String(itemPrice)) ₽"
        } else {
            priceProduct.text = "price"
        }
        if let imageURL = item.imageProduct, let url = URL(string: imageURL) {
            imageProduct.loadImageURL(url: url)
        }
    }
    // MARK: - IBAction methods.
    @IBAction private func deleteProduct(_ sender: Any) {
        guard let row = row else {
            return
        }
        delegate?.deleteItem(row)
    }
}
