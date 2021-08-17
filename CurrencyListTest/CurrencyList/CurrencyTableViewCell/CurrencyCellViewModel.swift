//
//  CurrencyCellViewModel.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 15.08.2021.
//

import Foundation

class CurrencyCellViewModel: CurrencyCellViewModelProtocol {
    
    var limitPrice: Double? {
        return fetchData()//если не использовать getchData, то ячейка динамически не обновляется, так как viewModel еще не обновилась
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
        dataManager.fetchCDData()
    }
    
}
