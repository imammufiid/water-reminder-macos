//
//  TimesUpView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI
import AVFoundation
import Combine

struct TimesUpView: View {
    @State private var timeRemaining = 10
    @State private var isRunning = false
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerCancellable: Cancellable?
    @Binding var isActive: Bool
    @EnvironmentObject var store: TimesUpStore
    @StateObject private var firebaseStore = FirebaseStore()
        
    var body: some View {
        VStack(spacing: 40) {
            Text("Time to hydrate! 💦")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.red)
                .scaleEffect(isActive ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true), value: isActive)
            
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(.orange)
                .rotationEffect(.degrees(isActive ? -15 : 15))
                .animation(.easeInOut(duration: 0.1).repeatForever(autoreverses: true), value: isActive)
            
            HStack {
                Button("Remind me later") {
                    isActive = false
                    store.markTimesUpDone()
                    firebaseStore.addReminder(isDrink: false)
                    stopTimer()
                }
                .buttonStyle(.plain)
                .padding()
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .keyboardShortcut(.escape)
                
                Button("Just drank!") {
                    isActive = false
                    store.markTimesUpDone()
                    firebaseStore.addReminder(isDrink: true)
                    stopTimer()
                }
                .buttonStyle(GrowingButton())
                .keyboardShortcut(.return)
            }
        }.onReceive(timer) { _ in
            if isRunning && timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isActive = false
                stopTimer()
                store.markTimesUpDone()
                firebaseStore.addReminder(isDrink: false)
            }
        }.onAppear {
            firebaseStore.fetchReminders()
            startTimer()
        }
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timerCancellable = timer.connect()
    }
    
    func stopTimer() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}

#Preview {
    TimesUpView(isActive: .constant(false))
}
