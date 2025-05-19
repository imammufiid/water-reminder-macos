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
