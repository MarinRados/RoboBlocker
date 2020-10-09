//
//  ServiceFactory.swift
//  RoboBlocker
//
//  Created by Marin on 09/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

class ServiceFactory {
    
    private static var persistanceServiceInstance: PersistenceServiceProtocol?
    
    static var persistenceService: PersistenceServiceProtocol {
        if let instance = persistanceServiceInstance {
            return instance
        }
        let persistenceService = PersistenceService()
        persistanceServiceInstance = persistenceService
        return persistenceService
    }
}
