//
//  PlusSnapshotDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/07/22.
//

import UIKit

final class PlusSnapshotDIContainer{
    
    // MARK: - Repositories
    func makePlusSnapshotRepository() -> PlusSnapshotRepository{
        return DefaultPlusSnapshotRepository()
    }
    
    // MARK: - Use Cases
    func makePlusSnapshotUseCase() -> PlusSnapshotUseCase{
        return PlusSnapshotUseCase(repository: makePlusSnapshotRepository())
    }
    
    // MARK: - Detail View
    func makePlusSnapshotViewModel(coordinator: PlusSnapshotFlowCoordinator) -> PlusSnapshotViewModel{
        return PlusSnapshotViewModel(coordinator: coordinator, plusSnapshotUseCase: makePlusSnapshotUseCase())
    }
    
    func makePlusSnapshotViewController(coordinator: PlusSnapshotFlowCoordinator) -> UIViewController{
        return PlusSnapshotViewController.create(with: makePlusSnapshotViewModel(coordinator: coordinator))
    }
    
    // MARK: - Flow Coordinators
    func makePlusSnapshotFlowCoordinator(navigationController: UINavigationController) -> PlusSnapshotFlowCoordinator {
        return PlusSnapshotFlowCoordinator(navigationController: navigationController,
                                   plusSnapshotDIContainer: self)
    }
}
