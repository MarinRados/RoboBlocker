//
//  GuardViewModel.swift
//  RoboBlocker
//
//  Created by Marin on 09/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

final class GuardViewModel {
    
    private var persistenceService: PersistenceServiceProtocol
    init(_ persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func getGuardStatus() -> Bool {
        return persistenceService.isGuardOn
    }
    
    func setGuardStatus(isOn: Bool) {
        persistenceService.isGuardOn = isOn
    }
}
