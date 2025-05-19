//
//  FirebaseStore.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import Foundation
import FirebaseFirestore

class FirebaseStore: ObservableObject {
    private var db = Firestore.firestore()
    @Published var reminders: [ReminderEntity] = []
    
    var reminderSummary: [ReminderSummaryChartEntity] {
        let todayReminders = reminders.filter { $0.createdAt.isToday }
        let drinkCount = todayReminders.filter { $0.isDrink }.count
        let nonDrinkCount = todayReminders.filter { !$0.isDrink }.count
        return [
            ReminderSummaryChartEntity(type: "Drink", count: drinkCount),
            ReminderSummaryChartEntity(type: "Other", count: nonDrinkCount)
        ]
    }
    
    func generateGroupedSummary(daysBack: Int) -> [ReminderDailyGroupedSummary] {
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(byAdding: .day, value: -daysBack + 1, to: now.startOfDay())!
        
        let filtered = reminders.filter { $0.createdAt >= startDate }
        
        let groupedByDay = Dictionary(grouping: filtered) { $0.createdAt.startOfDay() }
        
        var result: [ReminderDailyGroupedSummary] = []
        
        for offset in 0..<daysBack {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: now.startOfDay()) else { continue }
            let reminders = groupedByDay[date] ?? []
            let drinkCount = reminders.filter { $0.isDrink }.count
            let otherCount = reminders.filter { !$0.isDrink }.count
            
            result.append(ReminderDailyGroupedSummary(date: date, type: "Drink", count: drinkCount))
            result.append(ReminderDailyGroupedSummary(date: date, type: "Other", count: otherCount))
        }
        
        return result.sorted { $0.date < $1.date }
    }

    
    var dailyWeeklySummaries: [ReminderDailyGroupedSummary] {
        generateGroupedSummary(daysBack: 7)
    }
    
    var dailyMonthlySummaries: [ReminderDailyGroupedSummary] {
        generateGroupedSummary(daysBack: 30)
    }
    
    func fetchReminders() {
        db.collection("reminders")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    return
                }
                self.reminders = documents.compactMap { doc in
                    try? doc.data(as: ReminderEntity.self)
                }
            }
    }
    
    func addReminder(isDrink: Bool) {
        let reminder = ReminderEntity(isDrink: isDrink, createdAt: Date())
        do {
            _ = try db.collection("reminders").addDocument(from: reminder)
        } catch {
            print("Error add reminder: ", error)
        }
    }
}
