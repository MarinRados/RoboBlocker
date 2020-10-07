//
//  GuardCoordinator.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

final class GuardCoordinator: Coordinator {
    
    @discardableResult
    func start() -> UIViewController {
        let vc = GuardViewController()
        return vc
    }
}
