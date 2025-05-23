//
//  Date+Extension.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import Foundation

extension Date {
    func toReadable() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current  // or set specific TimeZone
        
        let formattedString = formatter.string(from: self)
        return formattedString
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func formattedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d" // Example: "May 19"
        return formatter.string(from: self)
    }
}
