//
//  AppDelegate.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import Foundation
import SwiftUI
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        UNUserNotificationCenter.current().delegate = self
        NotificationManager.requestNotificationPermission()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification Tapped: \(response.notification.request.identifier)")
        
        NotificationCenter.default.post(name: .notificationTapped, object: nil)
        completionHandler()
    }
}
