//
//  CurrencyCellViewModelDelegate.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 15.08.2021.
//

import Foundation

protocol CurrencyCellViewModelProtocol {
    var recordDate: String { get }
    var value: String { get }
    var limitPrice: Double? { get }
    init(currencyData: Currency)
}
