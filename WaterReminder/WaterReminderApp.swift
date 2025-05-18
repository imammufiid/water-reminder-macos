//
//  WaterReminderApp.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI

@main
struct mac_winter_reminderApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var store = TimesUpStore()
    @StateObject var networkStore = NetworkStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(
                    WindowAccessor { window in
                        window.setContentSize(NSSize(width: 400, height: 500))
                        window.center()
                        window.title = "Water Reminder"
                    }
                )
                .environmentObject(store)
                .environmentObject(networkStore)
                .onReceive(NotificationCenter.default.publisher(for: .notificationTapped)) { _ in
                    print("SwiftUI view detected notification tap")
                }
        }
    }
}

struct WindowAccessor: NSViewRepresentable {
    let onWindowAvailable: (NSWindow) -> Void
    
    func makeNSView(context: Context) -> NSView {
        DispatchQueue.main.async {
            if let window = NSApp.windows.first {
                onWindowAvailable(window)
            }
        }
        return NSView()
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}
