//
//  PersistenceServiceProtocol.swift
//  RoboBlocker
//
//  Created by Marin on 08/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

protocol PersistenceServiceProtocol {
    
    var allowContactsOnly: Bool { get set }
    var isGuardOn: Bool { get set }
    func add(number: String)
    func add(word: String)
    func delete(number: String)
    func delete(word: String)
    func getNumbers() -> [String]
    func getWords() -> [String]
}
