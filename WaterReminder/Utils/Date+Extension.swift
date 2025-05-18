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
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current  // or set specific TimeZone
        
        let formattedString = formatter.string(from: self)
        return formattedString
    }
}
