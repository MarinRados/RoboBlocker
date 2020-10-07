//
//  Fonts.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation
import UIKit

enum Font: String {
    
    case notoSansRegular = "NotoSans-Regular"
    case notoSansBold = "NotoSans-Bold"
    
    var name: String {
        return self.rawValue
    }
    
    func size(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return Font.notoSansRegular.size(size)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return Font.notoSansBold.size(size)
    }
}

extension UIFont {

    static let regular = Font.notoSansRegular
    static let bold = Font.notoSansBold
}
