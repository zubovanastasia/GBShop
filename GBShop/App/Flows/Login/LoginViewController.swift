//
//  LoginViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 18.04.2022.
//

import Foundation
import UIKit
import FirebaseCrashlytics
import Realm
import RealmSwift
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var loginText: UITextField!
    @IBOutlet private weak var passwordText: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    private let request = RequestFactory()
    private let loginDB = RealmDB()
    private var users: Results<User>?
    let disposeBag = DisposeBag()
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "loginVC"
        loginText.accessibilityIdentifier = "login"
        passwordText.accessibilityIdentifier = "password"
        loginButton.accessibilityIdentifier = "loginButton"
        cancelButton.accessibilityIdentifier = "cancelButton"
        setupUI()
        configureLoginBindings()
        addGesture()
        printRealmMessage()
        
        loginText.text = "login"
        passwordText.text = "password"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // MARK: - Private methods.
    private func printRealmMessage() {
        print("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    private func loadUser() {
        users = loginDB.loadUser()
    }
    private func formFill() -> Bool {
        guard loginText.text != "",
              passwordText.text != "" else {
            return false
        }
        return true
    }
    private func setupUI() {
        loginText.autocorrectionType = .no
    }
    private func configureLoginBindings() {
             let isLogin = loginText.rx.text.orEmpty
                 .map { $0.count >= 1 }
                 .share(replay: 1)
             let isPassword = passwordText.rx.text.orEmpty
                 .map { $0.count >= 1 }
                 .share(replay: 1)
             let isEverything = Observable.combineLatest(isLogin, isPassword) { (login, password) in
                 return login && password
             }
             isEverything
                 .bind(to: loginButton.rx.isEnabled)
                 .disposed(by: disposeBag)
             isEverything
                 .map { $0 ? 1.0 : 0.5 }
                 .bind(to: loginButton.rx.alpha)
                 .disposed(by: disposeBag)
         }
    // MARK: - Controller show methods.
    private func showTabBar() {
        LogLogin.logLogin(name: "login", key: "result", value: "success")
        let storyboard = UIStoryboard(name: "GBShopTabBar", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? GBShopTabBar {
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
        Crashlytics.crashlytics().log("user not found")
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
        LogLogin.logLogin(name: "login", key: "result", value: "failed")
        let alertController = UIAlertController(title: "Ошибка авторизации",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок(", style: .default, handler: nil))
        self.present(alertController, animated: true)
    }
    // MARK: - IBAction methods.
    @IBAction private func loginButton(_ sender: Any) {
        guard formFill() else { return
            self.showErrorAlert()
        }
        guard let users = users else {
            return
        }
        if users.contains(where: { $0.login == loginText.text && $0.password == passwordText.text }) {
            showTabBar()
        } else {
            showErrorAlert()
        }
        /*   let factory = request.makeLoginRequestFactory()
         let user = User(login: loginText.text, password: passwordText.text)
         factory.login(user: user) { response in
         DispatchQueue.main.async {
         switch response.result {
         case .success(let success): success.result == 1 ? self.showTabBar() : self.showError(success.errorMessage ?? "Неизвестная ошибка.")
         case .failure(let error): self.showError(error.localizedDescription)
         }
         }
         }*/
    }
    @IBAction private func cancelButton(_ sender: Any) {
        self.showMainViewController()
    }
}
