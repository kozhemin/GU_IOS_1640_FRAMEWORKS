//
//  RegistrationViewController.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 23.05.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    var userManager = UserManager()
    var onRegisterFinish: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        loginTextField.appDefaultFieldStyle()
        passwordTextField.appDefaultFieldStyle()
    }

    @IBAction func tapRegistration(_: Any) {
        guard let login = loginTextField.text, let password = passwordTextField.text
        else { return }

        if !userManager.create(login: login, password: password) {
            return
        }

        onRegisterFinish?()
    }
}
