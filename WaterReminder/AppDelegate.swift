//
//  AppDelegate.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import Foundation
import SwiftUI
import UserNotifications
import Firebase

class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        NotificationManager.requestNotificationPermission()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification Tapped: \(response.notification.request.identifier)")
        
        NotificationCenter.default.post(name: .notificationTapped, object: nil)
        completionHandler()
    }
}
