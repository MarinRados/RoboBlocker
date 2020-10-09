//
//  PersistenceService.swift
//  RoboBlocker
//
//  Created by Marin on 08/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

final class PersistenceService: PersistenceServiceProtocol {
    
    let userDefaults = UserDefaults.standard
    
    // MARK: - Get
    
    func getNumbers() -> [String] {
        return []
    }
    
    func getWords() -> [String] {
        return []
    }
    
    // MARK: - Add
    
    func add(number: String) {
        
    }
    
    func add(word: String) {
        
    }
    
    func saveContacts(_ contacts: [String]) {
        UserDefaults.group.contacts = contacts
    }
    
    // MARK: - Delete
    
    func delete(number: String) {
        
    }
    
    func delete(word: String) {
        
    }
    
    // MARK: - Keys
    
    fileprivate enum Keys {
        static let blockedNumbers = "blocked_numbers"
        static let filterWords = "filter_words"
    }
}
