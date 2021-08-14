//
//  CurrencyCell.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class CurrencyCell: UITableViewCell {

    let backgroundCellView: UIView = {
        let backgroundCellView = UIView()
        backgroundCellView.layer.cornerRadius = 10
        backgroundCellView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundCellView
    }()
    
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
        addSubview(backgroundCellView)
        backgroundCellView.addSubview(name)
        backgroundCellView.addSubview(dateLabel)
        backgroundCellView.addSubview(currentCourceLabel)
        
        NSLayoutConstraint.activate([
            backgroundCellView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundCellView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundCellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            backgroundCellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            backgroundCellView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        let nameLabel = UIStackView(arrangedSubviews: [name, dateLabel])
        nameLabel.distribution = .equalSpacing
        nameLabel.axis = .vertical
        nameLabel.spacing = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundCellView.addSubview(nameLabel)
        
        let stackLabels = UIStackView(arrangedSubviews: [nameLabel, currentCourceLabel])
        stackLabels.distribution = .equalSpacing
        stackLabels.axis = .horizontal
        stackLabels.spacing = 10
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        backgroundCellView.addSubview(stackLabels)
        
        NSLayoutConstraint.activate([
            stackLabels.centerYAnchor.constraint(equalTo: backgroundCellView.centerYAnchor),
            stackLabels.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            stackLabels.leftAnchor.constraint(equalTo: backgroundCellView.leftAnchor, constant: 10),
            stackLabels.rightAnchor.constraint(equalTo: backgroundCellView.rightAnchor, constant: -10),
            stackLabels.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 5),
            stackLabels.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -5)
        ])
    }
    
    func configureCell(currency: Currency) {
        self.dateLabel.text = currency.recordDate
        self.currentCourceLabel.text = currency.value
        self.name.text = "USD"
        
        if let text = (self.currentCourceLabel.text) {
            if let currentPrice = Double(text) {
                if currentPrice > Settings.shared.limitPrice {
                    self.backgroundCellView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    self.name.textColor = UIColor.white
                    self.dateLabel.textColor = UIColor.white
                    self.currentCourceLabel.textColor = UIColor.white
                    self.backgroundCellView.layer.borderColor = UIColor.clear.cgColor
                } else {
                    self.backgroundCellView.backgroundColor = .white
                    self.name.textColor = UIColor.black
                    self.dateLabel.textColor = UIColor.black
                    self.currentCourceLabel.textColor = UIColor.black
                    self.backgroundCellView.layer.borderWidth = 1
                    self.backgroundCellView.layer.borderColor = UIColor.black.cgColor
                }
            }
        }        
    }
}
