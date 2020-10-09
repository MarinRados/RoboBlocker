//
//  GuardViewModel.swift
//  RoboBlocker
//
//  Created by Marin on 09/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

final class GuardViewModel {
    
    var onChangedList: (() -> Void)?
    private var persistenceService: PersistenceServiceProtocol
    init(_ persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    // MARK: - Guard
    
    func getGuardStatus() -> Bool {
        return persistenceService.isGuardOn
    }
    
    func setGuardStatus(isOn: Bool) {
        persistenceService.isGuardOn = isOn
    }
    
    // MARK: - Block List
    
    var filteredWords: [String] {
        return persistenceService.getWords()
    }
    
    func addToFilter(word: String) {
        persistenceService.add(word: word.lowercased())
        onChangedList?()
    }
    
    func delete(index: Int) {
        if let word = filteredWords[safe: index] {
            persistenceService.delete(word: word)
            onChangedList?()
        }
    }
}
