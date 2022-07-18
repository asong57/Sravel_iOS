//
//  DetailFlowCoordinator.swift
//  Sravel
//
//  Created by asong on 2022/07/18.
//

import UIKit

class DetailFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let detailDIContainer: DetailDIContainer
    
    init(navigationController: UINavigationController, detailDIContainer: DetailDIContainer) {
        self.navigationController = navigationController
        self.detailDIContainer = detailDIContainer
    }
    
    func start(){
        let vc = detailDIContainer.makeDetailViewController(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
}
