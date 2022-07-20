//
//  DetailDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/07/18.
//

import UIKit

final class DetailDIContainer{
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Repositories
    func makeDetailRepository() -> DetailRepository{
        return DefaultDetailRepository()
    }
    
    // MARK: - Use Cases
    func makeDetailUseCase() -> DetailUseCase{
        return DetailUseCase(repository: makeDetailRepository())
    }
    
    // MARK: - Detail View
    func makeDetailViewModel(coordinator: DetailFlowCoordinator) -> DetailViewModel{
        return DetailViewModel(latitude: latitude, longitude: longitude, coordinator: coordinator, detailUseCase: makeDetailUseCase())
    }
    
    func makeDetailViewController(coordinator: DetailFlowCoordinator) -> UIViewController{
        return DetailViewController.create(with: makeDetailViewModel(coordinator: coordinator))
    }
    
    // MARK: - Flow Coordinators
    func makeDetailFlowCoordinator(navigationController: UINavigationController) -> DetailFlowCoordinator {
        return DetailFlowCoordinator(navigationController: navigationController,
                                   detailDIContainer: self)
    }
}
