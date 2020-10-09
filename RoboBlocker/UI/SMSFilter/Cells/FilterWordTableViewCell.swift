//
//  FilterWordTableViewCell.swift
//  RoboBlocker
//
//  Created by Marin on 10/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

final class FilterWordTableViewCell: UITableViewCell {

    private lazy var wordLabel: UILabel = {
        let wordLabel = UILabel()
        UILabelStyle.regular20Dark.apply(to: wordLabel)
        contentView.addSubview(wordLabel)
        return wordLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
        wordLabel.centerYInSuperview()
        wordLabel.anchor(leading: (contentView.leadingAnchor, 24))
    }
    
    var word: String = "" {
        didSet {
            wordLabel.text = word.lowercased()
        }
    }
}
