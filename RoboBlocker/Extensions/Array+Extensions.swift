//
//  Array+Extensions.swift
//  RoboBlocker
//
//  Created by Marin on 10/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

public extension Array {
    
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < self.count ? self[index] : nil
    }
}
