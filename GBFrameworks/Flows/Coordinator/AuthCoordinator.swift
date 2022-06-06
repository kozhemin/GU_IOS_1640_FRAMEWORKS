//
//  AuthCoordinator.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 23.05.2022.
//

import UIKit

final class AuthCoordinator: BaseCoordinator {
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?

    override func start() {
        showLoginModule()
    }

    private func showLoginModule() {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController
        else { return }

        controller.onRegister = { [weak self] in
            self?.showRegisterModule()
        }

        controller.onLogin = { [weak self] dataStr in
            print(dataStr)
            self?.onFinishFlow?()
        }

        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    private func showRegisterModule() {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "Registration") as? RegistrationViewController
        else { return }

        controller.onRegisterFinish = { [weak self] in
            self?.backToLoginModule()
            self?.onFinishFlow?()
        }

        rootController?.pushViewController(controller, animated: true)
    }

    private func backToLoginModule() {
        rootController?.popViewController(animated: true)
    }
}
