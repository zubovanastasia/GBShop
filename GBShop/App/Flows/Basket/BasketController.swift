//
//  BasketController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 26.04.2022.
//

import Foundation
import UIKit
import FirebaseCrashlytics

protocol BasketDelegate {
    func deleteItem(_ index: Int)
}

class BasketController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalSum: UILabel!
    let request = RequestFactory()
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        LogLogin.logLogin(name: "cart", key: "result", value: "success")
    }
    // MARK: - Delegate and DataSource methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if BasketSingle.shared.items.count == 0 {
            return 1
        } else {
            totalSum.text = "\(BasketSingle.shared.items.count) итоговая сумма \(String(BasketSingle.shared.items.map{ $0.productPrice! }.reduce(0, +))) ₽"
            return BasketSingle.shared.items.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if BasketSingle.shared.items.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Корзина пуста"
            self.tableView.tableFooterView = nil
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell") as? BasketCell
            cell?.configure(BasketSingle.shared.items[indexPath.row])
            cell?.delegate = self
            cell?.row = indexPath.row
            return cell ?? UITableViewCell()
        }
    }
    // MARK: - IBAction methods.
    @IBAction private func checkout(_ sender: Any) {
        let factory = request.makeBasketRequestFactory()
        let user = User(id: 123)
        let alert = UIAlertController(title: "Корзина", message: "Спасибо за покупку!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alert.addAction(action)
        factory.payBasket(user: user) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: {
                        BasketSingle.shared.items = []
                        LogLogin.logLogin(name: "checkout", key: "result", value: "success")
                        self.tableView.reloadData()
                    })
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
// MARK: - Extensions.
extension BasketController: BasketDelegate {
    func deleteItem(_ index: Int) {
        guard let itemName = BasketSingle.shared.items[index].productName else {
            Crashlytics.crashlytics().log("itemName not found")
            return
        }
        let factory = request.makeBasketRequestFactory()
        let request = BasketUser(productId: index)
        let alert = UIAlertController(title: "Корзина", message: "Удалить \(itemName) из корзины?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
            BasketSingle.shared.items.remove(at: index)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
        factory.deleteFromBasket(basket: request) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
