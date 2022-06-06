//
//  AppDelegate.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 14.05.2022.
//

import GoogleMaps
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var notificationCenter: NotificationManager?
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(GMS_API_KEY)
        startNotificationCener()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func startNotificationCener() {
        notificationCenter = NotificationManager.instance
        let timeIntrval = 60.0 * 30
        notificationCenter?.sendNotification(title: "My Title", subtitle: "My SubTitle", body: "My Body", timeIntrval: timeIntrval)
    }
    
}
