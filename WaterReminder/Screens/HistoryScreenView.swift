//
//  HistoryScreenView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI
import Charts

struct HistoryScreenView: View {
    @StateObject private var firebaseStore = FirebaseStore()
    @State private var sortAscending = true
    @State private var selectedDate: Date? = nil

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("History")
                .font(.largeTitle)
                .bold()
            
            Text("Your recent reminder activity")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            HStack {
                VStack {
                    Text("Today").font(.title3)
                    Chart(firebaseStore.reminderSummary) { item in
                        BarMark(
                            x: .value("Type", item.type),
                            y: .value("Count", item.count)
                        )
                        .foregroundStyle(item.type == "Drink" ? Color.blue : Color.red)
                    }
                }
                VStack {
                    Text("Weekly").font(.title3)
                    Chart(firebaseStore.dailyWeeklySummaries) { item in
                        BarMark(
                            x: .value("Day", item.date.formattedDay()),
                            y: .value("Count", item.count)
                        )
                        .foregroundStyle(item.type == "Drink" ? Color.blue : Color.red) // Different color per type
                        .position(by: .value("Type", item.type)) // Grouped bars per day
                    }
                }
            }
            VStack {
                Text("Monthly").font(.title3)
                
                Chart {
                    ForEach(["Drink", "Other"], id: \.self) { type in
                        ForEach(firebaseStore.dailyMonthlySummaries.filter { $0.type == type }) { item in
                            LineMark(
                                x: .value("Day", item.date.formattedDay()),
                                y: .value("Count", item.count)
                            )
                            .foregroundStyle(type == "Drink" ? Color.blue : Color.red)
                            .symbol(by: .value("Type", type))
                            .interpolationMethod(.catmullRom) // Smooth curve
                        }
                    }
                }
            }
        }
        .padding()
        .background(.blue.opacity(0.05))
        .onAppear {
            firebaseStore.fetchReminders()
        }
    }
}

#Preview {
    HistoryScreenView()
}
