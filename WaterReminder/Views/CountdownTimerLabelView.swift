//
//  CountdownTimerLabelView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI

struct CountdownTimerLabelView: View {
    @Binding var timeRemaining: Int
    @Binding var isRunning: Bool
    @Binding var isTimeUp: Bool
    
    let totalTime: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds/60
        let seconds = seconds%60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            CircularProgressBarView(timeRemaining: $timeRemaining, totalTime: totalTime)
            
            Text("\(formatTime(timeRemaining))")
                .font(.largeTitle)
                .bold()
        }.onReceive(timer) { _ in
            isTimeUp = false
            if isRunning && timeRemaining > 0 {
                timeRemaining -= 1
            }
            if timeRemaining < 1 {
                isRunning = false
                isTimeUp = true
            }
        }
        .onChange(of: totalTime) { oldValue, newValue in
            timeRemaining = newValue
        }
        .padding()
    }
}

#Preview {
    CountdownTimerView(totalTime: 60, isTimeUp: .constant(false), repeatReminderSelected: .constant(1))
}

