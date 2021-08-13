//
//  MainViewController.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class MainViewController: UITableViewController {

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
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return USDCourse.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyCell
        cell.configureCell(currency: USDCourse[indexPath.row])
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
}
