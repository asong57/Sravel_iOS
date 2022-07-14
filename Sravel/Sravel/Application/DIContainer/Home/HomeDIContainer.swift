//
//  HomeDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/07/14.
//

import UIKit

final class HomeDIContainer{
    
    // MARK: - Repositories
    func makeHomeRepository() -> HomeRepository{
        return DefaultHomeRepository()
    }
    
    // MARK: - Use Cases
    func makeHomeUseCase() -> HomeUseCase{
        return HomeUseCase(repository: makeHomeRepository())
    }
    
    // MARK: - Login View
    func makeHomeViewModel(coordinator: HomeFlowCoordinator) -> HomeViewModel{
        return HomeViewModel(coordinator: coordinator, homeUseCase: makeHomeUseCase())
    }
    
    func makeHomeViewController(coordinator: HomeFlowCoordinator) -> UIViewController{
        return HomeViewController.create(with: makeHomeViewModel(coordinator: coordinator))
    }
    
    // MARK: - Flow Coordinators
    func makeHomeFlowCoordinator(navigationController: UINavigationController) -> HomeFlowCoordinator {
        return HomeFlowCoordinator(navigationController: navigationController,
                                   homeDIContainer: self)
    }
}
