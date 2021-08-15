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
        fetchData()
        self.spinner.stopAnimating()
        configureRefreshControl()
        checkLimitPrice()
    }
    
    private func configureLimitButton() {
        let limitButton = UIButton(type: .custom)
        limitButton.setTitle("Лимит", for: .normal)
        limitButton.setTitleColor(.blue, for: .normal)
        limitButton.addTarget(self, action: #selector(limitPrice), for: .touchUpInside)
        let item = UIBarButtonItem(customView: limitButton)
        self.navigationItem.setRightBarButton(item, animated: true)
    }
    
    private func fetchData() {
        let month = Month()
        let fromDate = month.dateMonthAgo()
        let toDate = month.startMonth()
        networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: Constant.usdCode) { }
    }
    
    private func fetchDataAndDelete() {
        let month = Month()
        let fromDate = month.dateMonthAgo()
        let toDate = month.startMonth()
        networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: Constant.usdCode) {
            self.currencyRate = []
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
        fetchDataAndDelete()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        refControl.endRefreshing()
    }
    
    private func checkLimitPrice() {
        currencyRate.forEach { (price) in
            if let price = Double(price.value) {
                if let limit = dataManager.fetchData() {
                    if price > limit {
                        showMessageAlert(title: "", message: "Обнаружена цена выше лимита")
                    }
                }
            }
        }
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
