//
//  CountdownScreenView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI
import AVFoundation

struct CountdownScreenView: View {
    @State private var isTimeUp = false
    @State private var selectedTimeIndex = 0
    @State private var selectedRepeatOptionIndex = 0
    @State private var player: AVAudioPlayer?
    
    let timeOptions = [10, 60, 120, 600]
    let repeatOptions = ["Yes", "No"]
    
    
    var body: some View {
        VStack {
            if isTimeUp {
                TimesUpView(isActive: $isTimeUp)
            } else {
                Picker("Interval Time", selection: $selectedTimeIndex) {
                    ForEach(0..<timeOptions.count, id: \.self) { index in
                        Text("\(timeOptions[index]) seconds")
                    }
                }
                .pickerStyle(.menu)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                
                Picker("Repeat", selection: $selectedRepeatOptionIndex) {
                    ForEach(0..<repeatOptions.count, id: \.self) { index in
                        Text("\(repeatOptions[index])")
                    }
                }
                .pickerStyle(.menu)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                
                CountdownTimerView(
                    totalTime: timeOptions[selectedTimeIndex],
                    isTimeUp: $isTimeUp,
                    repeatReminderSelected: $selectedRepeatOptionIndex)
            }
        }.onAppear {
            NotificationManager.requestNotificationPermission()
        }.onChange(of: isTimeUp) {
            if isTimeUp {
                playBellSound()
                NotificationManager.showNotification(title: "Time to hydrate! 💦", body: "Grab a sip of water and give your body some love 💧")
            } else {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.player?.stop()
                }
            }
        }
    }
    
    private func playBellSound() {
        guard let url = Bundle.main.url(forResource: "bell", withExtension: "wav") else {
            print("⚠️ bell.wav not found in bundle")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Repeat indefinitely
            DispatchQueue.global(qos: .userInitiated).async {
                player?.play()
            }
        } catch {
            print("🎵 Failed to play sound: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CountdownScreenView()
}
