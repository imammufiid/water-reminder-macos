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
    
    var body: some View {
        VStack(spacing: 40) {
            Text("DRINK TIME!!!")
                .font(.system(size: 48, weight: .bold))
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
                Button("Naah, wait") {
                    isActive = false
                    store.markTimesUpDone()
                }
                .buttonStyle(.plain)
                .padding()
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .keyboardShortcut(.escape)
                
                Button("OK, I'm Drinking") {
                    isActive = false
                    store.markTimesUpDone()
                }
                .buttonStyle(GrowingButton())
                .keyboardShortcut(.return)
            }
        }
    }
}

#Preview {
    TimesUpView(isActive: .constant(false))
}
