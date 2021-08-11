//
//  NetworkManager.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import Foundation

struct NetworkManager {
        
    func fetchXML(delegate: XMLParserDelegate, fromDate: String, toDate: String, currencyCode: String) {
        let urlString = "http://cbr.ru/scripts/XML_dynamic.asp?date_req1=\(fromDate)&date_req2=\(toDate)&VAL_NM_RQ=\(currencyCode)"
        
        guard let url = URL(string: urlString) else { return }
               
        if let parser = XMLParser(contentsOf: url) {
            parser.delegate = delegate
            parser.parse()
        }        
    }
}
