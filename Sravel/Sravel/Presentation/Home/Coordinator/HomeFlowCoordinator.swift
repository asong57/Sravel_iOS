//
//  HomeFlowCoordinator.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import UIKit

class HomeFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let homeDIContainer: HomeDIContainer
    
    init(navigationController: UINavigationController, homeDIContainer: HomeDIContainer) {
        self.navigationController = navigationController
        self.homeDIContainer = homeDIContainer
    }
    
    func start() {
        let vc = homeDIContainer.makeHomeViewController(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func moveToDetailViewController(latitude: Double, longitude: Double) {
        let detailDIContainer = DetailDIContainer(latitude: latitude, longitude: longitude)
        var detailCoordinator = DetailFlowCoordinator(navigationController: navigationController!, detailDIContainer: detailDIContainer)
        detailCoordinator.start()
    }
    
    func moveToPlusSnapshotViewController() {
        let plusSnapshotDIContainer = PlusSnapshotDIContainer()
        var plusCoordinator = PlusSnapshotFlowCoordinator(navigationController: navigationController!, plusSnapshotDIContainer: plusSnapshotDIContainer)
        plusCoordinator.start()
    }
    
    func moveToHomeSearchViewController() {
        let homeSearchViewController = HomeSearchViewController()
        navigationController?.pushViewController(homeSearchViewController, animated: false)
    }
}
