//
//  UserProfileViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 19.04.2022.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var welcomeText: UILabel!
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Controller show methods.
    private func showChangeUserData() {
        let storyboard = UIStoryboard(name: "ChangeUserData", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? ChangeUserDataViewController {
            self.present(viewController, animated: true)
        }
    }
    private func showLogout() {
        let storyboard = UIStoryboard(name: "MainGBShop", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? GBShopViewController {
            self.present(viewController, animated: true)
        }
    }
    // MARK: - IBAction methods.
    @IBAction private func changeUserData(_ sender: Any) {
        self.showChangeUserData()
    }
    @IBAction private func logoutButton(_ sender: Any) {
        self.showLogout()
    }
}
