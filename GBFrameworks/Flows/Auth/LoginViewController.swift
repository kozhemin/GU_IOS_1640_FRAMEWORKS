//
//  LoginViewController.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 23.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var userManager = UserManager()
    var onLogin: ((String) -> Void)?
    var onRegister: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLoginBindings()
    }
    
    private func configureUI() {
        loginTextField.appDefaultFieldStyle()
        passwordTextField.appDefaultFieldStyle()
    }
    
    func configureLoginBindings() {
        Observable
            .combineLatest(
                loginTextField.rx.text,
                passwordTextField.rx.text
            )
            .map { login, password in
                return !(login ?? "").isEmpty && (password ?? "").count >= 3
            }
            .bind { [weak loginButton] inputFilled in
                loginButton?.isEnabled = inputFilled
            }
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
