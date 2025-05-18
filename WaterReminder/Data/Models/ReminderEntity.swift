//
//  ReminderEntity.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import Foundation
import FirebaseFirestore

struct ReminderEntity: Identifiable, Codable {
    @DocumentID var id: String?
    var isDrink: Bool = false
    var createdAt: Date
}
