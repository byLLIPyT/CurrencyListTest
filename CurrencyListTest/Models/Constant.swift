//
//  Constant.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 15.08.2021.
//

import Foundation
import UIKit

struct Constant {
    static let cellIdentifier = "Cell"
    static let usdCode = "R01235"
    static let heightCell: CGFloat = 80
}

struct XMLConstant {
    static let xmlDateAttribute = "Date"
    static let xmlTag = "Record"
    static let xmlAttribute = "Value"
}

struct CellConstant {
    static let cornerRadius: CGFloat = 10
    static let smallFontSize: CGFloat = 16
    static let largeFontSize: CGFloat = 22
    static let color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    static let whiteColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let clearColor = UIColor.clear
    static let indent: CGFloat = 5
    static let borderWidth: CGFloat = 1
}

struct TextConstant {
    static let titleLimitButton = "Лимит"
    static let messageAlert = "Обнаружена цена выше лимита"
    static let usdDescription = "USD"
    static let errorTitle = "Ошибка"
    static let errorFetchXML = "Не удалось прочитать файл XML"
    static let placeholderText = "Введите курс"
    static let limitAlertTitle = "Установка цены"
    static let limitAlertMessage = "Введите лимит"
    static let cancelTitle = "Отмена"
}

struct CoreDataTexts {
    static let coreDataEntityName = "LimitPrice"
    static let errorReadText = "Не могу прочитать."
    static let errorSaveText = "Не могу записать."
}
