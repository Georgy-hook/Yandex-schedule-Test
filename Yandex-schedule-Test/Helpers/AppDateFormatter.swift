//
//  AppDateFormatter.swift
//  Yandex-schedule-Test
//
//  Created by Georgy on 16.12.2023.
//

import Foundation

class AppDateFormatter {
    static let shared = AppDateFormatter()
    private let dateFormatter: DateFormatter
    private let fullDateFormatter: DateFormatter
    private let timeFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        fullDateFormatter = DateFormatter()
        fullDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "H:mm"
    }

    func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func formatFullDate(_ dateString: String) -> String? {
        if let date = fullDateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMM"
            outputFormatter.locale = Locale(identifier: "ru_RU")
            return outputFormatter.string(from: date)
        }
        return nil
    }

    func formatTime(_ dateString: String) -> String? {
        if let date = fullDateFormatter.date(from: dateString) {
            return timeFormatter.string(from: date)
        }
        return nil
    }
}
