//
//  LabelStyles.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

import Foundation
import UIKit

enum UILabelStyle {
    
    static let base = UIViewStyle<UILabel> { _ in
        
    }
    
    static let bold32Main = base.composing { label in
        label.font = Font.bold(size: 32)
        label.textColor = .main
    }
    
    static let bold24Dark = base.composing { label in
        label.font = Font.bold(size: 24)
        label.textColor = .dark
    }
    
    static let regular20Dark = base.composing { label in
        label.font = Font.regular(size: 20)
        label.textColor = .dark
    }
    
    static let regularText = base.composing { label in
        label.font = Font.regular(size: 17)
        label.textColor = .dark
    }
}
