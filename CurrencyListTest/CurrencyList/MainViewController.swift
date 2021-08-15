//
//  MainViewController.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var refControl = UIRefreshControl()
    var USDCourse: [Currency] = []
    var value = String()
    var recordDate = String()
    var elementName = String()
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.addSubview(spinner)
        let month = Month()
        let fromDate = month.dateMonthAgo()
        let toDate = month.startMonth()
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        configureLimitButton()
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
        spinner.startAnimating()
        networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: "R01235") { }
        self.spinner.stopAnimating()
        configureRefreshControl()
        checkLimitPrice()
    }
    
    private func configureLimitButton() {
        let limitButton = UIButton(type: .custom)
        limitButton.setTitle("Установить лимит", for: .normal)
        limitButton.setTitleColor(.blue, for: .normal)
        limitButton.addTarget(self, action: #selector(limitPrice), for: .touchUpInside)
        let item = UIBarButtonItem(customView: limitButton)
        self.navigationItem.setRightBarButton(item, animated: true)
    }
        
    @objc func limitPrice() {
        showAlert()
    }
    
    private func configureRefreshControl() {
        refControl.attributedTitle = NSAttributedString(string: "")
        refControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refControl)
    }
    
    @objc func refresh() {
        let month = Month()
        let fromDate = month.dateMonthAgo()
        let toDate = month.startMonth()
        DispatchQueue.main.async {
            self.networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: "R01235") {
                self.USDCourse = []
            }
            self.tableView.reloadData()
        }
        refControl.endRefreshing()
    }
    
    private func checkLimitPrice() {
        USDCourse.forEach { (price) in
            if let price = Double(price.value) {
                if price > Settings.shared.limitPrice {
                    showMessageAlert(title: "Price", message: "More then limit price")
                }
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return USDCourse.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyCell
        cell.configureCell(currency: USDCourse[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
