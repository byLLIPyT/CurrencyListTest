//
//  CurrencyCell.swift
//  CurrencyListTest
//
//  Created by Александр Уткин on 11.08.2021.
//

import UIKit

class CurrencyCell: UITableViewCell {

    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.boldSystemFont(ofSize: 22)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    let currentCourceLabel: UILabel = {
        let currentCourceLabel = UILabel()
        currentCourceLabel.font = UIFont.boldSystemFont(ofSize: 26)
        currentCourceLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentCourceLabel
    }()
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dateLabel)
        addSubview(currentCourceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
