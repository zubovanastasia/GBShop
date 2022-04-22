//
//  ChangeUserDataViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 18.04.2022.
//

import Foundation
import UIKit

class ChangeUserDataViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var email: UITextField!
    @IBOutlet private weak var age: UITextField!
    @IBOutlet private weak var gender: UISegmentedControl!
    @IBOutlet private weak var password: UITextField!
    private let request = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func formFill() -> Bool {
        guard username.text != "",
              email.text != "",
              age.text != "",
              password.text != "" else {
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
    @IBAction private func saveButton(_ sender: Any) {
        guard formFill() else { return
            self.showErrorAlert()
        }
        let factory = request.makeChangeUserDataRequestFactory()
        let user = User(login: username.text,
                        password: password.text,
                        email: email.text,
                        gender: String(gender.selectedSegmentIndex),
                        bio: age.text)
        factory.changeUserData(user: user) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let success): success.result == 1 ? self.showUserProfile() : self.showError(success.errorMessage ?? "Неизвестная ошибка.")
                case .failure(let error): self.showError(error.localizedDescription)
                }
            }
        }
    }
    @IBAction private func cancelButton(_ sender: Any) {
        self.showUserProfile()
    }
}
