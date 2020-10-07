//
//  Coordinator.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: class {
    
    @discardableResult
    func start() -> UIViewController
}
