//
//  SharedData.swift
//  RoboBlocker
//
//  Created by Marin on 09/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import CallKit
import Foundation

extension UserDefaults {
    static let suiteName = "group.mrados.RoboBlocker.sharedData"
    static let group = UserDefaults(suiteName: suiteName)!
    
    private enum Keys {
        static let allowOnlyContactList = "allow_contacts"
        static let isGuardOn = "is_guard_on"
        static let contacts = "contacts"
        static let blockList = "block_list"
        static let filterWords = "filter_words"
    }
    
    var blockList: [String] {
        get {
            guard let array = UserDefaults.group.array(forKey: Keys.blockList) as? [String] else {
                return ["2539501212"]
            }
            return array
        }
        set {
            UserDefaults.group.setValue(newValue, forKeyPath: Keys.blockList)
            CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "marinrados.RoboBlocker.CallDirectoryHandler", completionHandler: nil)
        }
    }
    
    var contacts: [String] {
        get {
            guard let array = UserDefaults.group.array(forKey: Keys.contacts) as? [String] else {
                return []
            }
            return array
        }
        set {
            UserDefaults.group.setValue(newValue, forKeyPath: Keys.contacts)
        }
    }
    
    var filterWords: [String] {
        get {
            guard let array = UserDefaults.group.array(forKey: Keys.filterWords) as? [String] else {
                return ["free", "won"]
            }
            return array
        }
        set {
            UserDefaults.group.setValue(newValue, forKeyPath: Keys.filterWords)
        }
    }
    
    var allowContactsOnly: Bool {
        get {
            return UserDefaults.group.bool(forKey: Keys.allowOnlyContactList)
        }
        set {
            UserDefaults.group.set(newValue, forKey: Keys.allowOnlyContactList)
        }
    }
    
    var isGuardOn: Bool {
        get {
            return UserDefaults.group.bool(forKey: Keys.isGuardOn)
        }
        set {
            UserDefaults.group.set(newValue, forKey: Keys.isGuardOn)
        }
    }
}
