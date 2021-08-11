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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "Cell")
        configureLimitButton()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return USDCourse.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = USDCourse[indexPath.row].value
        
        /*
        if let text = cell.textLabel?.text, let currentPrice = Double(text) {
            if currentPrice > 75.0 {
                cell.backgroundColor = .green
            }
        }      
        */
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
