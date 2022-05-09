//
//  CatalogController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 26.04.2022.
//

import Foundation
import UIKit

class CatalogController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var tableView: UITableView!
    let request = RequestFactory()
    var catalog: [CatalogResponse] = []
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        self.setupTableView()
    }
    // MARK: - Setup methods.
    private func setupTableView() {
        let factory = request.makeCatalogRequestFactory()
        factory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let result):
                self.catalog = result
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - Delegate and DataSource methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catalog.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalogCell") as? CatalogCell
        cell?.configure(catalog[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "segueGoods", sender: cell)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let cell = sender as? CatalogCell else {
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let goodsPage = segue.destination as! GoodsController
        goodsPage.productId = catalog[indexPath.row].productId
    }
}
