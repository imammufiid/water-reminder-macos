//
//  TimesUpView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI
import AVFoundation

struct TimesUpView: View {
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
                }
                .buttonStyle(GrowingButton())
                .keyboardShortcut(.return)
            }
        }.onAppear {
            firebaseStore.fetchReminders()
        }
    }
}

#Preview {
    TimesUpView(isActive: .constant(false))
}
