//
//  CountdownTimerView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI

struct CountdownTimerView: View {
    let totalTime: Int
    @State private var timeRemining: Int
    @State private var isRunning: Bool = false
    @Binding var isTimeUp: Bool
    @Binding var repeatReminderSelected: Int
    @EnvironmentObject var store: TimesUpStore
    
    
    init(totalTime: Int, isTimeUp: Binding<Bool>, repeatReminderSelected: Binding<Int>) {
        self.totalTime = totalTime
        self._timeRemining = State(initialValue: totalTime)
        self._isTimeUp = isTimeUp
        self._repeatReminderSelected = repeatReminderSelected
    }
    
    var body: some View {
        VStack {
            ZStack {
                CountdownTimerLabelView(
                    timeRemaining: $timeRemining,
                    isRunning: $isRunning,
                    isTimeUp: $isTimeUp,
                    totalTime: totalTime)
            }.frame(width: 250, height: 250)
            Spacer()
            HStack {
                if !isRunning {
                    Button("Start") {
                        isRunning = true
                        store.isTimesUpDone = false
                    }
                    .buttonStyle(GrowingButton())
                    .keyboardShortcut(.return)
                }
            }
        }
        .padding()
        .onChange(of: store.isTimesUpDone) {
            guard store.isTimesUpDone else {return}
            isRunning = store.isTimesUpDone && repeatReminderSelected == 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                store.isTimesUpDone = false
            }
        }
    }
}

#Preview {
    CountdownTimerView(totalTime: 60, isTimeUp: .constant(false), repeatReminderSelected: .constant(0))
}
