//
//  LoginDIContainer.swift
//  Sravel
//
//  Created by asong on 2022/06/18.
//

import Foundation
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
    func makeLoginViewModel() -> LoginViewModel{
        return LoginViewModel(loginUseCase: makeLoginUseCase())
    }
    
    func makeLoginViewController() -> UIViewController{
        return LoginViewController.create(with: makeLoginViewModel())
    }
    
    // MARK: - Flow Coordinators
    func makeLoginFlowCoordinator(navigationController: UINavigationController) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(navigationController: navigationController,
                                           loginDIContainer: self)
    }
}
