//
//  ReminderSummaryChartEntity.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 19/05/25.
//

import Foundation

struct ReminderSummaryChartEntity: Identifiable {
    var id = UUID()
    var type: String
    var count: Int
}
