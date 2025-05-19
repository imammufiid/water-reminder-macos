//
//  HistoryScreenView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI

struct HistoryScreenView: View {
    @StateObject private var firebaseStore = FirebaseStore()
    @State private var sortAscending = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("History")
                .font(.largeTitle)
                .bold()
            
            Text("Your recent reminder activity")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            List(firebaseStore.reminders) { reminder in
                VStack(alignment: .leading, spacing: 4) {
                    Text("Drink? \(reminder.isDrink)")
                    Text("CreatedAt: \(reminder.createdAt.toReadable())")
                }
                .padding(.vertical, 8)
            }
            .listStyle(PlainListStyle())
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
