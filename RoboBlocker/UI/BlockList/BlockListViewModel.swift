//
//  BlockListViewModel.swift
//  RoboBlocker
//
//  Created by Marin on 09/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

final class BlockListViewModel {
    
    var onChangedList: (() -> Void)?
    private var persistenceService: PersistenceServiceProtocol
    init(_ persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    // MARK: - Contacts
    
    func getContactListStatus() -> Bool {
        return persistenceService.allowContactsOnly
    }
    
    func setContactListStatus(isOn: Bool) {
        persistenceService.allowContactsOnly = isOn
    }
    
    func saveContacts(_ contacts: [String]) {
        persistenceService.saveContacts(contacts)
    }
    
    // MARK: - Block List
    
    var blockList: [String] {
        return persistenceService.getNumbers()
    }
    
    func addToBlockList(number: String) {
        persistenceService.add(number: number)
        onChangedList?()
    }
    
    func delete(number: String) {
        persistenceService.delete(number: number)
        onChangedList?()
    }
}
