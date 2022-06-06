//
//  NotificationManager.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 06.06.2022.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    let center = UNUserNotificationCenter.current()
    
    private init() {
        auth()
    }
    
    public func sendNotification(title: String, subtitle: String, body: String, timeIntrval: TimeInterval) {
        
        center.getNotificationSettings {[weak self] settings in
            guard let self = self else { return }
            if settings.authorizationStatus == .denied {
                return
            }
            
            self.sendNotificatioRequest(
                content: self.makeNotificationContent(title, subtitle, body),
                trigger: self.makeIntervalNotificatioTrigger(timeIntrval)
            )
        }
    }
    
    private func sendNotificatioRequest(content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(
            identifier: "alaram",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { error in
            if let error = error {
                print("Ошибка: ", error.localizedDescription)
            }
        }
    }
    
    private func auth() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Разрешение получено.")
            } else {
                print("Разрешение не получено.")
            }
        }
    }
    
    private func makeNotificationContent(_ title: String, _ subtitle: String, _ body: String) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.badge = 1
        return content
    }
    
    private func makeIntervalNotificatioTrigger(_ timeIntrval: TimeInterval) -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(
            timeInterval: timeIntrval,
            repeats: false
        )
    }
}
