//
//  MainViewController.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class MainViewController: UITableViewController {

    var USDCource: [USD] = []
     
    var testData: [USD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "Cell")
        testData.append(USD(recordDate: "01/08/2021", value: "73.5"))
        testData.append(USD(recordDate: "02/08/2021", value: "75.5"))
        
        configureLimitButton()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = testData[indexPath.row].value
        
        if let text = cell.textLabel?.text, let currentPrice = Double(text) {
            if currentPrice > 75.0 {
                cell.backgroundColor = .green
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
        print("new price")
    }
    

}
