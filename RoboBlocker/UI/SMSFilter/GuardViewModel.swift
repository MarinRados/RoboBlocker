//
//  GuardViewModel.swift
//  RoboBlocker
//
//  Created by Marin on 09/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation

final class GuardViewModel {
    
    func getGuardStatus() -> Bool {
        return UserDefaults.group.isGuardOn
    }
    
    func setGuardStatus(isOn: Bool) {
        UserDefaults.group.isGuardOn = isOn
    }
}
