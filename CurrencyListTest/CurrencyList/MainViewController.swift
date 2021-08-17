//
//  MainViewController.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let dataManager = DataManager()
    
    private var refControl = UIRefreshControl()
    var currencyRate: [Currency] = []
    var value = String()
    var recordDate = String()
    var elementName = String()
    let networkManager = NetworkManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(spinner)
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
        tableView.separatorStyle = .none
        configureLimitButton()
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
        spinner.startAnimating()
        fetchData(reset: false)
        self.spinner.stopAnimating()
        configureRefreshControl()
        checkLimitPrice()
    }
    
    private func configureLimitButton() {
        let limitButton = UIButton(type: .custom)
        limitButton.setTitle(TextConstant.titleLimitButton, for: .normal)
        limitButton.setTitleColor(.blue, for: .normal)
        limitButton.addTarget(self, action: #selector(limitPrice), for: .touchUpInside)
        let item = UIBarButtonItem(customView: limitButton)
        navigationItem.setRightBarButton(item, animated: true)
    }
    
    private func fetchData(reset: Bool) {
        let formaDate = FormatDate()
        let fromDate = formaDate.dayOfMonth(returnCurrentDay: false)
        let toDate = formaDate.dayOfMonth(returnCurrentDay: true)
        if reset {
            networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: Constant.usdCode) { self.currencyRate = [] }
        } else {
            networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: Constant.usdCode) {  }
        }
    }
    
    @objc func limitPrice() {
        showAlert()
    }
    
    private func configureRefreshControl() {
        refControl.attributedTitle = NSAttributedString(string: "")
        refControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refControl)
    }
        
    private func cellViewModel(for indexPath: IndexPath) -> CurrencyCellViewModelProtocol? {
        let currency = currencyRate[indexPath.row]
        return CurrencyCellViewModel(currencyData: currency)
    }
    
    @objc func refresh() {
        fetchData(reset: true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        refControl.endRefreshing()
    }
    
    private func checkLimitPrice() {
        let wrongPrice = currencyRate
            .compactMap { Double($0.value) }
            .first { $0 > dataManager.fetchCDData() ?? 0 && dataManager.fetchCDData() != nil } != nil
        
        if wrongPrice {
            showMessageAlert(title: "", message: TextConstant.messageAlert)
        }
    }
    
    func showAlert() {
        let dataManager = DataManager()
        let limitAlert = UIAlertController(title: TextConstant.limitAlertTitle, message: TextConstant.limitAlertMessage, preferredStyle: .alert)
        limitAlert.addTextField { (text) in
            text.placeholder = TextConstant.placeholderText
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
        let cancelAction = UIAlertAction(title: TextConstant.cancelTitle, style: .cancel, handler: nil)
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

    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyRate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as! CurrencyCell
        cell.viewModel = cellViewModel(for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.heightCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

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
            
            let newCurrency = Currency(recordDate: recordDate.replacingOccurrences(of: ".", with: "/"), value: value.replacingOccurrences(of: ",", with: "."), limitPrice: dataManager.fetchCDData())
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
