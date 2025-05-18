//
//  TimesUpStore.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import Foundation

class TimesUpStore: ObservableObject {
    @Published var isTimesUpDone: Bool = false
    
    func markTimesUpDone() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isTimesUpDone = true
        }
    }
}
