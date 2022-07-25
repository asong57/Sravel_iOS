//
//  PlusSnapshotFlowCoordinator.swift
//  Sravel
//
//  Created by asong on 2022/07/22.
//

import UIKit

class PlusSnapshotFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let plusSnapshotDIContainer: PlusSnapshotDIContainer
    
    init(navigationController: UINavigationController, plusSnapshotDIContainer: PlusSnapshotDIContainer) {
        self.navigationController = navigationController
        self.plusSnapshotDIContainer = plusSnapshotDIContainer
    }
    
    func start(){
        let vc = plusSnapshotDIContainer.makePlusSnapshotViewController(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
}
