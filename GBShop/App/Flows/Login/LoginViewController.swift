//
//  LoginViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 18.04.2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var loginText: UITextField!
    @IBOutlet private weak var passwordText: UITextField!
    private let request = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        loginText.text = "login"
        passwordText.text = "password"
    }
    private func formFill() -> Bool {
        guard loginText.text != "",
              passwordText.text != "" else {
            return false
        }
        return true
    }
    private func showUserProfile() {
        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? UserProfileViewController {
            self.present(viewController, animated: true)
        }
    }
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "MainGBShop", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? GBShopViewController {
            self.present(viewController, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        self.scrollView.addGestureRecognizer(gesture)
    }
    @objc private func handleGesture() {
        self.scrollView.endEditing(true)
    }
    private func addObservers() {
        NotificationCenter.default
            .addObserver(self, selector: #selector(handleKeyboardWillShow) , name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    private func removeObservers() {
        NotificationCenter.default
            .removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default
            .removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc private func handleKeyboardWillShow() {
        self.scrollView.contentInset.bottom += 110
    }
    @objc private func handleKeyboardWillHide() {
        self.scrollView.contentInset.bottom = 0
    }
    
    // MARK: - Error alert private methods.
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Неправильный логин или пароль.",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    private func showError(_ errorMessage: String) {
        let alertController = UIAlertController(title: "Ошибка авторизации",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок(", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
    @IBAction private func loginButton(_ sender: Any) {
        guard formFill() else { return
            self.showErrorAlert()
        }
        let factory = request.makeLoginRequestFactory()
        let user = User(login: loginText.text, password: passwordText.text)
        factory.login(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let success): success.result == 1 ? self.showUserProfile() : self.showError(success.errorMessage ?? "Неизвестная ошибка.")
                case .failure(let error): self.showError(error.localizedDescription)
                }
            }
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.showMainViewController()
    }
}
