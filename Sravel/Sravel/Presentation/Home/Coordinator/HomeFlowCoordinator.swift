//
//  HomeFlowCoordinator.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import UIKit

class HomeFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let homeDIContainer: HomeDIContainer
    
    init(navigationController: UINavigationController, homeDIContainer: HomeDIContainer) {
        self.navigationController = navigationController
        self.homeDIContainer = homeDIContainer
    }
    
    func start(){
        let vc = homeDIContainer.makeHomeViewController(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func moveToDetailViewController(){
        let detailDIContainer = DetailDIContainer()
        var detailCoordinator = DetailFlowCoordinator(navigationController: navigationController!, detailDIContainer: detailDIContainer)
        detailCoordinator.start()
    }
}
