//
//  LoginFlowCoordinator.swift
//  Sravel
//
//  Created by asong on 2022/06/18.
//

import UIKit

class LoginFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let loginDIContainer: LoginDIContainer
    
    init(navigationController: UINavigationController, loginDIContainer: LoginDIContainer) {
        self.navigationController = navigationController
        self.loginDIContainer = loginDIContainer
    }
    
    func start(){
        let vc = loginDIContainer.makeLoginViewController(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func moveToSignUpViewController(){
        let signUpDIContainer = SignUpDIContainer()
        var signUpCoordinator = SignUpFlowCoordinator(navigationController: navigationController!, signUpDIContainer: signUpDIContainer)
        signUpCoordinator.start()
    }
}
