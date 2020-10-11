//
//  PersistenceServiceMock.swift
//  RoboBlockerTests
//
//  Created by Marin on 11/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation
@testable import RoboBlocker

final class PersistenceServiceMock: PersistenceServiceProtocol {
    
    var mockNumbersStorage = ["1234567890"]
    var mockWordsStorage = ["free", "won"]
    
    var isGuardOn: Bool = false
    
    var allowContactsOnly: Bool = false
    
    func add(number: String) {
        mockNumbersStorage.append(number)
    }
    
    func add(word: String) {
        mockWordsStorage.append(word)
    }
    
    func saveContacts(_ contacts: [String]) {}
    
    func delete(number: String) {
        mockNumbersStorage.removeAll { $0 == number }
    }
    
    func delete(word: String) {
        mockWordsStorage.removeAll { $0 == word }
    }
    
    func getNumbers() -> [String] {
        return mockNumbersStorage
    }
    
    func getWords() -> [String] {
        return mockWordsStorage
    }
    
}
