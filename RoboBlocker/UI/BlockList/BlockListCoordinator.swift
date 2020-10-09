//
//  BlockListCoordinator.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

final class BlockListCoordinator: Coordinator {
    
    @discardableResult
    func start() -> UIViewController {
        let vc = BlockListViewController()
        let vm = BlockListViewModel(ServiceFactory.persistenceService)
        vc.viewModel = vm
        return vc
    }
}
