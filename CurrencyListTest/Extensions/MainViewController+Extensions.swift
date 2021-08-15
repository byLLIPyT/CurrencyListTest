//
//  Extensions.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

extension MainViewController: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == XMLConstant.xmlTag {
            value = String()
            if let currentDate = attributeDict[XMLConstant.xmlDateAttribute] {
                recordDate += currentDate
            }
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == XMLConstant.xmlTag {
            let newCurrency = Currency(recordDate: recordDate.replacingOccurrences(of: ".", with: "/"), value: value.replacingOccurrences(of: ",", with: "."))
            currencyRate.append(newCurrency)
            recordDate = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            if self.elementName == XMLConstant.xmlAttribute {
                value += data
            }
        }
    }
}

extension MainViewController {
       
    func showAlert() {
        let dataManager = DataManager()
        let limitAlert = UIAlertController(title: "Установка цены", message: "Введите лимит", preferredStyle: .alert)
        limitAlert.addTextField { (text) in
            text.placeholder = "Введите курс"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (limit) in
            let textLimit = limitAlert.textFields?.first?.text
            if let textLimit = textLimit, let doubleLimit = Double(textLimit) {
                dataManager.saveData(value: doubleLimit)
            } else {
                dataManager.saveData(value: 0.0)                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        limitAlert.addAction(okAction)
        limitAlert.addAction(cancelAction)
        present(limitAlert, animated: true, completion: nil)
    }
    
    func showMessageAlert(title: String, message: String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAlert)
        present(errorAlert, animated: true, completion: nil)
    }
}
