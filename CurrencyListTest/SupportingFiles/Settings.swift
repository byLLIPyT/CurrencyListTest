//
//  Settings.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import Foundation

class Settings {
    static let shared = Settings()
    
    var limitPrice: Double {
        set { UserDefaults.standard.set(newValue, forKey: "limit") }
        get { return UserDefaults.standard.double(forKey: "limit")}
    }
}
