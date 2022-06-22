//
//  SignUpFlowCoordinator.swift
//  Sravel
//
//  Created by asong on 2022/06/22.
//

import UIKit

class SignUpFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let signUpDIContainer: SignUpDIContainer
    
    init(navigationController: UINavigationController, signUpDIContainer: SignUpDIContainer) {
        self.navigationController = navigationController
        self.signUpDIContainer = signUpDIContainer
    }
    
    func start(){
        let vc = signUpDIContainer.makeSignUpViewController(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func moveToLoginViewController(){
        navigationController?.popViewController(animated: false)
    }
}
