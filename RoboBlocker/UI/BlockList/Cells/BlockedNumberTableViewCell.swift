//
//  BlockedNumberTableViewCell.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

final class BlockedNumberTableViewCell: UITableViewCell {
    
    private lazy var numberLabel: UILabel = {
        let nameLabel = UILabel()
        UILabelStyle.regular20Dark.apply(to: nameLabel)
        contentView.addSubview(nameLabel)
        return nameLabel
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
        numberLabel.centerYInSuperview()
        numberLabel.anchor(leading: (contentView.leadingAnchor, 24))
    }
    
    var phoneNumber: String = "" {
        didSet {
            numberLabel.text = phoneNumber
        }
    }
}
