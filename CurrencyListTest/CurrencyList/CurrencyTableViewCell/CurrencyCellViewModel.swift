//
//  CurrencyCellViewModel.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 15.08.2021.
//

import Foundation

class CurrencyCellViewModel: CurrencyCellViewModelProtocol {
    
    var limitPrice: Double? {
        return fetchData()
    }
        
    private var currencyData: Currency
    
    private let dataManager = DataManager()
    
    var recordDate: String {
        return currencyData.recordDate
    }
    
    var value: String {
        return currencyData.value
    }
    
    required init(currencyData: Currency) {
        self.currencyData = currencyData
    }
    
    func fetchData() -> Double? {
        /// в ячейке таблицы не должно быть взаимодейсвтия с базой данных. в твоем случае все взаимодействие должно быть во view controller. Ячейка должна оставаться тупой максимально. она просто отображает данные. без логики какой либо.
        dataManager.fetchCDData()
    }
    
}
