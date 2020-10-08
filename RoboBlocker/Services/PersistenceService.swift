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
    
    var allowContactsOnly: Bool {
        get {
            return userDefaults.bool(forKey: Keys.allowOnlyContactList)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.allowOnlyContactList)
        }
    }
    
    var isGuardOn: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isGuardOn)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isGuardOn)
        }
    }
    
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
    
    // MARK: - Delete
    
    func delete(number: String) {
        
    }
    
    func delete(word: String) {
        
    }
    
    // MARK: - Keys
    
    fileprivate enum Keys {
        static let blockedNumbers = "blocked_numbers"
        static let filterWords = "filter_words"
        static let allowOnlyContactList = "allow_contacts"
        static let isGuardOn = "is_guard_on"
    }
}
