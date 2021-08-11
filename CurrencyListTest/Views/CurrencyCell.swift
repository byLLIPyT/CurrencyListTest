//
//  CurrencyCell.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class CurrencyCell: UITableViewCell {

    let name: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 22)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    let currentCourceLabel: UILabel = {
        let currentCourceLabel = UILabel()
        currentCourceLabel.font = UIFont.boldSystemFont(ofSize: 22)
        currentCourceLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentCourceLabel
    }()
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStack() {
        addSubview(name)
        addSubview(dateLabel)
        addSubview(currentCourceLabel)
        
        let nameLabel = UIStackView(arrangedSubviews: [name, dateLabel])
        nameLabel.distribution = .equalSpacing
        nameLabel.axis = .vertical
        nameLabel.spacing = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        let stackLabels = UIStackView(arrangedSubviews: [nameLabel, currentCourceLabel])
        stackLabels.distribution = .equalSpacing
        stackLabels.axis = .horizontal
        stackLabels.spacing = 10
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackLabels)
        
        NSLayoutConstraint.activate([
            stackLabels.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackLabels.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackLabels.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackLabels.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stackLabels.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackLabels.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configureCell(currency: USD) {
        self.dateLabel.text = currency.recordDate
        self.currentCourceLabel.text = currency.value
        self.name.text = "USD"
        
        if let text = (self.currentCourceLabel.text) {
            if let currentPrice = Double(text) {
                if currentPrice > Settings.shared.limitPrice {
                    self.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                } else {
                    self.backgroundColor = .white
                }
            }
        }        
    }
}
