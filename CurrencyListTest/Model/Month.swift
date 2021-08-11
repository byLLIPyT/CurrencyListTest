//
//  Month.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import Foundation

class Month {
    
    private let calendar = Calendar.current
    
    func startMonth() -> String {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        dateFormatter.string(from: date)
        return dateFormatter.string(from: date).replacingOccurrences(of: ".", with: "/")
    }
    
    func dateMonthAgo() -> String {
        let dateFormatter = DateFormatter()
        let newDate = calendar.date(byAdding: .month, value: -1, to: Date())
        if let newDate = newDate {
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
            dateFormatter.string(from: newDate)
            return dateFormatter.string(from: newDate).replacingOccurrences(of: ".", with: "/")
        } else {
            return ""
        }
    }
}
