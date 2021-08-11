//
//  Extensions.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

extension MainViewController: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Record" {
            nameCurrency = String()
            value = String()
            if let currentDate = attributeDict["Date"] {
                recordDate += currentDate
            }
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "Record" {
            let newCurrency = USD(recordDate: recordDate.replacingOccurrences(of: ".", with: "/"), value: value.replacingOccurrences(of: ",", with: "."))
            USDCourse.append(newCurrency)
            recordDate = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            if self.elementName == "Value" {
                value += data
            }
        }
    }
}

extension MainViewController {
    func showAlert() {
        let limitAlert = UIAlertController(title: "Установка цены", message: "Введите лимит", preferredStyle: .alert)
        limitAlert.addTextField { (text) in
            text.placeholder = "Введите курс"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (limit) in
            let textLimit = limitAlert.textFields?.first?.text
            if let textLimit = textLimit, let doubleLimit = Double(textLimit) {
                Settings.shared.limitPrice = doubleLimit
            } else {
                Settings.shared.limitPrice = 0.0
            }
            
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        limitAlert.addAction(okAction)
        limitAlert.addAction(cancelAction)
        present(limitAlert, animated: true, completion: nil)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
