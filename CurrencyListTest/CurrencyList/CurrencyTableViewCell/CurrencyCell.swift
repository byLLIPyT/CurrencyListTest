//
//  CurrencyCell.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    var viewModel: CurrencyCellViewModelProtocol! {
        didSet {
            self.dateLabel.text = viewModel.recordDate
            self.currentCourceLabel.text = viewModel.value
            self.limitPrice = viewModel.limitPrice
            self.name.text = TextConstant.usdDescription
            self.configureCell()
        }
    }
    
    let backgroundCellView: UIView = {
        let backgroundCellView = UIView()
        backgroundCellView.layer.cornerRadius = CellConstant.cornerRadius
        backgroundCellView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundCellView
    }()
    
    let name: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: CellConstant.largeFontSize)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.boldSystemFont(ofSize: CellConstant.smallFontSize)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    let currentCourceLabel: UILabel = {
        let currentCourceLabel = UILabel()
        currentCourceLabel.font = UIFont.boldSystemFont(ofSize: CellConstant.largeFontSize)
        currentCourceLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentCourceLabel
    }()
    
    var limitPrice: Double?
    
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
            backgroundCellView.leftAnchor.constraint(equalTo: leftAnchor, constant: CellConstant.indent),
            backgroundCellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -CellConstant.indent),
            backgroundCellView.topAnchor.constraint(equalTo: topAnchor, constant: CellConstant.indent),
            backgroundCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CellConstant.indent)
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
            stackLabels.leftAnchor.constraint(equalTo: backgroundCellView.leftAnchor, constant: CellConstant.indent),
            stackLabels.rightAnchor.constraint(equalTo: backgroundCellView.rightAnchor, constant: -CellConstant.indent),
            stackLabels.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: CellConstant.indent),
            stackLabels.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -CellConstant.indent)
        ])
    }
    
    func configureCell(){
        guard
            let text = (self.currentCourceLabel.text),
            let currentPrice = Double(text),
            let limitPrice = limitPrice,
            currentPrice > limitPrice
        else {
            self.backgroundCellView.backgroundColor = CellConstant.whiteColor
            self.name.textColor = CellConstant.blackColor
            self.dateLabel.textColor = CellConstant.blackColor
            self.currentCourceLabel.textColor = CellConstant.blackColor
            self.backgroundCellView.layer.borderWidth = CellConstant.borderWidth
            self.backgroundCellView.layer.borderColor = CellConstant.blackColor.cgColor
            return
        }
        self.backgroundCellView.backgroundColor = CellConstant.color
        self.name.textColor = CellConstant.whiteColor
        self.dateLabel.textColor = CellConstant.whiteColor
        self.currentCourceLabel.textColor = CellConstant.whiteColor
        self.backgroundCellView.layer.borderColor = CellConstant.clearColor.cgColor
    }
}
