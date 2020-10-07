//
//  Colors.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    static let main = rgb(114, 137, 218)
    static let grayText = rgb(153, 170, 181)
    static let dark = rgb(44, 47, 51)
    static let text = rgb(35, 39, 42)
}
