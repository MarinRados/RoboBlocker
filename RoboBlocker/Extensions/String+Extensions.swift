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
    
    func formattedAsPhoneNumber() -> String {
        var count = 0
        
        let characters = self.enumerated().map { value -> [Character] in
            if value.offset > 0 && value.offset % 3 == 0 && count < 2 {
                count += 1
                return [" ", value.element]
            } else {
                return [value.element]
            }
        }
        return String(characters.joined())
    }
}
