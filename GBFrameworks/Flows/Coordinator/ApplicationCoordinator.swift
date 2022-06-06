//
//  ApplicationCoordinator.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 23.05.2022.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    override func start() {
        if UserDefaults.isLogin ?? false {
            toMain()
            return
        }

        toAuth()
    }

    private func toMain() {
        let coordinator = MainCoordinator()

        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }

        addDependency(coordinator)
        coordinator.start()
    }

    private func toAuth() {
        let coordinator = AuthCoordinator()

        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
