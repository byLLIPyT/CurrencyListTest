//
//  Month.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import Foundation

class FormatDate {
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    
    init() {
        setupDateFormatter()
    }
    
    func dayOfMonth(returnCurrentDay: Bool) -> String {
        let newDate = calendar.date(byAdding: .month, value: returnCurrentDay ? 0 : -1, to: Date())
        if let newDate = newDate {
            dateFormatter.string(from: newDate)
            return dateFormatter.string(from: newDate).replacingOccurrences(of: ".", with: "/")
        } else {
            return ""
        }
    }
    
    private func setupDateFormatter() {
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
    }
}
