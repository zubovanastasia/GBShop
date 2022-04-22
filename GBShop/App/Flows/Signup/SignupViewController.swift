//
//  SignupViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 18.04.2022.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var emailText: UITextField!
    @IBOutlet private weak var passwordText: UITextField!
    private let request = RequestFactory()
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // MARK: - User data form method.
    private func formFill() -> Bool {
        guard emailText.text != "",
              passwordText.text != "" else {
            return false
        }
        return true
    }
    // MARK: - Controller show methods.
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
    // MARK: - Error alert private methods.
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Все поля обязательны для заполнения",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertController, animated: true)
    }
    private func showError(_ errorMessage: String) {
        let alertController = UIAlertController(title: "Ошибка сервера",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertController, animated: true)
    }
    
    // MARK: - Keyboard animation methods.
    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        self.scrollView.addGestureRecognizer(gesture)
    }
    private func addObservers() {
        NotificationCenter.default
            .addObserver(self, selector: #selector(handleKeyboardWillShow) , name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    // MARK: - Objective-C methods.
    @objc private func handleGesture() {
        self.scrollView.endEditing(true)
    }
    @objc private func handleKeyboardWillShow() {
        self.scrollView.contentInset.bottom += 110
    }
    @objc private func handleKeyboardWillHide() {
        self.scrollView.contentInset.bottom = 0
    }
    // MARK: - IBAction methods.
    @IBAction private func signupButton(_ sender: Any) {
        guard formFill() else { return
            self.showErrorAlert()
        }
        let factory = request.makeSignupRequestFactory()
        let user = User(password: passwordText.text, email: emailText.text)
        factory.signup(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let success): success.result == 1 ? self.showUserProfile() : self.showError(success.errorMessage ?? "Неизвестная ошибка.")
                case .failure(let error): self.showError(error.localizedDescription)
                }
            }
        }
    }
    @IBAction private func cancelButton(_ sender: Any) {
        self.showMainViewController()
    }
}
