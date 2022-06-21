//
//  SignupViewController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 18.04.2022.
//

import Foundation
import UIKit
import FirebaseCrashlytics
import Realm
import RealmSwift
import RxSwift
import RxCocoa

class SignupViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var emailText: UITextField!
    @IBOutlet private weak var passwordText: UITextField!
    private let request = RequestFactory()
    private let signupDB = RealmDB()
    private let realm = try! Realm()
    private var users: Results<User>?
    private var usertoDB = [User]()
    let disposeBag = DisposeBag()
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        view.accessibilityIdentifier = "signupVC"
        super.viewDidLoad()
        users = signupDB.loadUser()
        setupUI()
        configureSignupBindings()
        printRealmMessage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // MARK: - Private methods.
   /* private func formFill() -> Bool {
        guard emailText.text != "",
              passwordText.text != "" else {
            return false
        }
        return true
    }*/
    private func printRealmMessage() {
        print("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    private func signNewUser() {
        guard emailText.text != "" && passwordText.text != "" else {
            showErrorAlert();
            return
        }
        guard let users = users else {
            return
        }
        if users.contains(where: { $0.login == emailText.text }) == true {
            guard let index = users.firstIndex(where: { $0.login == emailText.text }) else {
                return
            }
            try! realm.write ({
                users[index].password = passwordText.text!
            })
            showErrorAlertUserDB()
        } else {
            usertoDB.append(User(login: emailText.text!, password: passwordText.text!))
            signupDB.saveUser(usertoDB)
            showSuccess()
        }
    }
    private func setupUI() {
        emailText.autocorrectionType = .no
    }
    private func configureSignupBindings() {
             let isLogin = emailText.rx.text.orEmpty
                 .map { $0.count >= 1 }
                 .share(replay: 1)
             let isPassword = passwordText.rx.text.orEmpty
                 .map { $0.count >= 1 }
                 .share(replay: 1)
             let isEverything = Observable.combineLatest(isLogin, isPassword) { (login, password) in
                 return login && password
             }
             isEverything
                 .bind(to: emailText.rx.isEnabled)
                 .disposed(by: disposeBag)
             isEverything
                 .map { $0 ? 1.0 : 0.5 }
                 .bind(to: emailText.rx.alpha)
                 .disposed(by: disposeBag)
         }
    // MARK: - Controller show methods.
    /*private func showUserProfile() {
        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? UserProfileViewController {
            self.present(viewController, animated: true)
        }
    }*/
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "MainGBShop", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? GBShopViewController {
            self.present(viewController, animated: true)
        }
    }
    private func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        viewController?.modalPresentationStyle = .fullScreen
        if let viewController = viewController as? LoginViewController {
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
    /*private func showError(_ errorMessage: String) {
        let alertController = UIAlertController(title: "Ошибка сервера",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default))
        self.present(alertController, animated: true)
    }*/
    private func showErrorAlertUserDB() {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Пользователь уже зарегистрирован",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .cancel))
        self.present(alertController, animated: true)
    }
    private func showSuccess() {
        let alertController = UIAlertController(title: "Регистрация!",
                                                message: "Регистрация прошла успешно",
                                                preferredStyle: .alert)
        let alertItem = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.showLoginViewController()
        }
        alertController.addAction(alertItem)
        present(alertController, animated: true)
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
    // MARK: - IBAction methods.
    @IBAction private func signupButton(_ sender: Any) {
        signNewUser()
        /*guard formFill() else { return
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
        }*/
    }
    @IBAction private func cancelButton(_ sender: Any) {
        self.showMainViewController()
    }
}
