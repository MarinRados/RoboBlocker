//
//  MainCoordinator.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    
    private lazy var childCoordinators: [Coordinator] = [
        InfoCoordinator(),
        BlockListCoordinator(),
        GuardCoordinator()
    ]
    
    @discardableResult
    func start() -> UIViewController {
        let tabBarController = createTabBarController()
        tabBarController.showAsRoot()
        return tabBarController
    }
}

// MARK: - Main Tab Bar

extension MainCoordinator {

    private func tabBarItem(for coordinator: Coordinator) -> UITabBarItem {
        switch coordinator {
        case is InfoCoordinator:
            return .info
        case is BlockListCoordinator:
            return .blockList
        case is GuardCoordinator:
            return .smsGuard
        default:
            fatalError("No tab bar set for this coordinator!")
        }
    }

    private func createTabBarController() -> UITabBarController {

        let tabBarController = UITabBarController()

        let viewControllers = childCoordinators.map { coordinator -> UIViewController in

            let vc = coordinator.start()
            vc.tabBarItem = tabBarItem(for: coordinator)
            return vc
        }
        
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.barTintColor = .main
        tabBarController.tabBar.unselectedItemTintColor = .dark
        tabBarController.viewControllers = viewControllers
        return tabBarController
    }
}
