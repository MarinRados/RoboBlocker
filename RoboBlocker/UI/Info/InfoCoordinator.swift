//
//  InfoCoordinator.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

final class InfoCoordinator: Coordinator {
    
    @discardableResult
    func start() -> UIViewController {
        let vc = InfoViewController()
        return vc
    }
}
