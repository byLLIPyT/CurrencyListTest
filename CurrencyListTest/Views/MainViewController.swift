//
//  MainViewController.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class MainViewController: UITableViewController {

    var USDCourse: [USD] = []
    var nameCurrency = String()
    var value = String()
    var recordDate = String()
    var elementName = String()
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "Cell")
        configureLimitButton()
        networkManager.fetchXML(delegate: self, fromDate: "01/08/2021", toDate: "10/08/2021", currencyCode: "R01235")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return USDCourse.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = USDCourse[indexPath.row].value
        cell.editingStyle = 
        cell.detailTextLabel?.text = USDCourse[indexPath.row].recordDate
        
        if let text = (cell.textLabel?.text) {
            if let currentPrice = Double(text) {
                if currentPrice > Settings.shared.limitPrice {
                    cell.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                } else {
                    cell.backgroundColor = .white
                }
            }
        }
        return cell
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
