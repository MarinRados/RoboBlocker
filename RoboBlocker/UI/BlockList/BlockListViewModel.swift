//
//  BlockListViewModel.swift
//  RoboBlocker
//
//  Created by Marin on 09/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

final class BlockListViewModel {
    
    let persistenceService: PersistenceServiceProtocol
    init(_ persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func getContactListStatus() -> Bool {
        return UserDefaults.group.allowContactsOnly
    }
    
    func setContactListStatus(isOn: Bool) {
        UserDefaults.group.allowContactsOnly = isOn
    }
    
    func saveContacts(_ contacts: [String]) {
        persistenceService.saveContacts(contacts)
        print(UserDefaults.group.contacts)
    }
}
