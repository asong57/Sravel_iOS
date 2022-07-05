//
//  LoginDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import UIKit

final class LoginDIContainer{
    
    // MARK: - Repositories
    func makeLoginRepository() -> LoginRepository{
        return DefaultLoginRepository()
    }
    
    // MARK: - Use Cases
    func makeLoginUseCase() -> LoginUseCase{
        return LoginUseCase(repository: makeLoginRepository())
    }
    
    // MARK: - Login View
    func makeLoginViewModel(coordinator: LoginFlowCoordinator) -> LoginViewModel{
        return LoginViewModel(coordinator: coordinator, loginUseCase: makeLoginUseCase())
    }
    
    func makeLoginViewController(coordinator: LoginFlowCoordinator) -> UIViewController{
        return LoginViewController.create(with: makeLoginViewModel(coordinator: coordinator))
    }
    
    // MARK: - Flow Coordinators
    func makeLoginFlowCoordinator(navigationController: UINavigationController) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(navigationController: navigationController,
                                           loginDIContainer: self)
    }
}
