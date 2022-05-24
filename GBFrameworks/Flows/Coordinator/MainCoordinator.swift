//
//  MainCoordinator.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 24.05.2022.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?

    override func start() {
        showMapModule()
    }

    private func showMapModule() {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "Map") as? MapViewController
        else { return }

        controller.onExit = { [weak self] in
            self?.appExit()
            self?.onFinishFlow?()
        }

        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    private func appExit() {
        let coordinator = AuthCoordinator()
        coordinator.start()
    }
}
