//
//  Month.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import Foundation

class Month {
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    func startMonth() -> String {
        let date = Date()
        setupDateFormatter(toDate: date)
        return dateFormatter.string(from: date).replacingOccurrences(of: ".", with: "/")
    }
    
    func dateMonthAgo() -> String {
        let newDate = calendar.date(byAdding: .month, value: -1, to: Date())
        if let newDate = newDate {
            setupDateFormatter(toDate: newDate)
            return dateFormatter.string(from: newDate).replacingOccurrences(of: ".", with: "/")
        } else {
            return ""
        }
    }
    
    private func setupDateFormatter(toDate: Date) -> DateFormatter {
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        dateFormatter.string(from: toDate)
        return dateFormatter
    }
}
