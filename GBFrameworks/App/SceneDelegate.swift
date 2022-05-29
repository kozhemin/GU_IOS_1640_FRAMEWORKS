//
//  SceneDelegate.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 14.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?
    let visualBlureEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
 
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light

        coordinator = ApplicationCoordinator()
        coordinator?.start()
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        removeBlure()
    }

    func sceneWillResignActive(_: UIScene) {
        addBlure()
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    private func addBlure() {
        guard let window = window else { return }
        visualBlureEffectView.frame = window.bounds
        window.rootViewController?.view.addSubview(visualBlureEffectView)
    }
    
    private func removeBlure() {
        visualBlureEffectView.removeFromSuperview()
    }
}
