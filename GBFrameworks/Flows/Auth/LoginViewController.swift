//
//  LoginViewController.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 23.05.2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    var userManager = UserManager()
    var onLogin: ((String) -> Void)?
    var onRegister: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        loginTextField.appDefaultFieldStyle()
        passwordTextField.appDefaultFieldStyle()
    }

    @IBAction func tapLogin(_: Any) {
        guard let login = loginTextField.text, let password = passwordTextField.text
        else { return }

        if !userManager.login(login: login, password: password) {
            print("...login or password invalid")
            return
        }

        UserDefaults.isLogin = true
        onLogin?("onLogin")
    }

    @IBAction func tapRegister(_: Any) {
        onRegister?()
    }
}
