//
//  SignUpDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/06/22.
//

import UIKit

final class SignUpDIContainer{
    
    // MARK: - Repositories
    func makeSignUpRepository() -> SignUpRepository{
        return DefaultSignUpRepository()
    }
    
    // MARK: - Use Cases
    func makeSignUpUseCase() -> SignUpUseCase{
        return SignUpUseCase(repository: makeSignUpRepository())
    }
    
    // MARK: - Login View
    func makeSignUpViewModel(coordinator: SignUpFlowCoordinator) -> SignUpViewModel{
        return SignUpViewModel(coordinator: coordinator, signUpUseCase: makeSignUpUseCase())
    }
    
    func makeSignUpViewController(coordinator: SignUpFlowCoordinator) -> UIViewController{
        return SignUpViewController.create(with: makeSignUpViewModel(coordinator: coordinator))
    }
    
    // MARK: - Flow Coordinators
    func makeLoginFlowCoordinator(navigationController: UINavigationController) -> SignUpFlowCoordinator {
        return SignUpFlowCoordinator(navigationController: navigationController,
                                           signUpDIContainer: self)
    }
}
