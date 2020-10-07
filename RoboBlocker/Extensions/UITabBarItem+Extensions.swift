//
//  UITabBarItem+Extensions.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

extension UITabBarItem {

    static var info: UITabBarItem {
        let item = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "info").withRenderingMode(.alwaysTemplate), selectedImage: #imageLiteral(resourceName: "info").withRenderingMode(.alwaysTemplate))
        item.centerImage()
        item.title = "Info"
        item.setTitleTextAttributes([NSAttributedString.Key.font: Font.bold(size: 10)], for: .normal)
        return item
    }

    static var blockList: UITabBarItem {
        let item = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "blockList").withRenderingMode(.alwaysTemplate), selectedImage: #imageLiteral(resourceName: "blockList").withRenderingMode(.alwaysTemplate))
        item.centerImage()
        item.title = "Block List"
        item.setTitleTextAttributes([NSAttributedString.Key.font: Font.bold(size: 10)], for: .normal)
        return item
    }

    static var smsGuard: UITabBarItem {
        let item = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "sms").withRenderingMode(.alwaysTemplate), selectedImage: #imageLiteral(resourceName: "sms").withRenderingMode(.alwaysTemplate))
        item.centerImage()
        item.title = "SMS Guard"
        item.setTitleTextAttributes([NSAttributedString.Key.font: Font.bold(size: 10)], for: .normal)
        return item
    }
    
    func centerImage() {
        self.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
    }

}
