//
//  PersistenceServiceProtocol.swift
//  RoboBlocker
//
//  Created by Marin on 08/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

protocol PersistenceServiceProtocol {
    
    func add(number: String)
    func add(word: String)
    func saveContacts(_ contacts: [String])
    func delete(number: String)
    func delete(word: String)
    func getNumbers() -> [String]
    func getWords() -> [String]
}
