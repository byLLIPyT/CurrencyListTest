//
//  MainViewController.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class MainViewController: UITableViewController {

    private var refControl = UIRefreshControl()
    var USDCourse: [USD] = []
    var value = String()
    var recordDate = String()
    var elementName = String()
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let month = Month()
        let fromDate = month.dateMonthAgo()
        let toDate = month.startMonth()
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "Cell")
        configureLimitButton()
        networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: "R01235")
        configureRefreshControl()
        
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
            self.networkManager.fetchXML(delegate: self, fromDate: fromDate, toDate: toDate, currencyCode: "R01235")
            self.tableView.reloadData()
        }
        refControl.endRefreshing()
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
