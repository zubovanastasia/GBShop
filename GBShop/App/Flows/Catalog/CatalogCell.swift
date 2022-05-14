//
//  CatalogCell.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 29.04.2022.
//

import Foundation
import UIKit

class CatalogCell: UITableViewCell {
    @IBOutlet private weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet private weak var amountProduct: UILabel!
    @IBOutlet private weak var priceProduct: UILabel!
    
    // MARK: - Configure method.
    func configure(_ item: CatalogResponse) {
        nameProduct.text = item.productName ?? "name"
        if let itemPrice = item.price {
            priceProduct.text = "\(String(itemPrice)) ₽"
        } else {
            priceProduct.text = "price"
        }
        if let imageURL = item.imageProduct, let url = URL(string: imageURL) {
            imageProduct.loadImageURL(url: url)
        }
    }
    // MARK: - Plus/minus button methods.
    private func pressPlus() {
        guard let amount = Int((amountProduct?.text)!) else { return }
        let newAmount = amount + 1
        amountProduct!.text = String(newAmount)
    }
    private func pressMinus () {
        guard let amount = Int((amountProduct?.text)!) else { return }
        let newAmount = amount - 1
        amountProduct!.text = String(newAmount)
        if amount <= 0 {
            self.amountProduct.text = "0"
        } else {
            self.amountProduct!.text = String(newAmount)
        }
    }
    // MARK: - IBAction methods.
    @IBAction func addInWishlist(_ sender: Any) {
    }
    @IBAction func adInBasket(_ sender: Any) {
    }
    @IBAction func addQuantity(_ sender: Any) {
        self.pressPlus()
    }
    @IBAction func deleteQuantity(_ sender: Any) {
        self.pressMinus()
    }
}
