//
//  PersistenceService.swift
//  RoboBlocker
//
//  Created by Marin on 08/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

final class PersistenceService: PersistenceServiceProtocol {
    
    private let groupDefaults = UserDefaults.group
    
    // MARK: - User Options
    
    var isGuardOn: Bool {
        get {
            return groupDefaults.isGuardOn
        }
        set {
            groupDefaults.isGuardOn = newValue
        }
    }
    
    var allowContactsOnly: Bool {
        get {
            return groupDefaults.allowContactsOnly
        }
        set {
            groupDefaults.allowContactsOnly = newValue
        }
    }
    
    // MARK: - Get
    
    func getNumbers() -> [String] {
        return groupDefaults.blockList
    }
    
    func getWords() -> [String] {
        return groupDefaults.filterWords
    }
    
    // MARK: - Add
    
    func add(number: String) {
        var list = groupDefaults.blockList
        list.append(number)
        groupDefaults.blockList = list
    }
    
    func add(word: String) {
        var list = groupDefaults.filterWords
        list.append(word)
        groupDefaults.filterWords = list
    }
    
    func saveContacts(_ contacts: [String]) {
        groupDefaults.contacts = contacts
    }
    
    // MARK: - Delete
    
    func delete(number: String) {
        var list = groupDefaults.blockList
        list.removeAll { $0 == number }
        groupDefaults.blockList = list
    }
    
    func delete(word: String) {
        var list = groupDefaults.filterWords
        list.removeAll { $0 == word }
        groupDefaults.filterWords = list
    }
}
