//
//  String+Extensions.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

extension String {
    
    public var isEmptyOrWhitespace: Bool {
        let whitespace = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace).isEmpty
    }
}
