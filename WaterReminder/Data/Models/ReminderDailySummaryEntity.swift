//
//  ReminderDailySummaryEntity.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 19/05/25.
//

import Foundation

struct ReminderDailyGroupedSummary: Identifiable {
    let id = UUID()
    let date: Date
    let type: String // "Drink" or "Other"
    let count: Int
}
