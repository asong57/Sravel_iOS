//
//  LoginCoordinator.swift
//  Sravel
//
//  Created by asong on 2022/05/26.
//

import UIKit

protocol LoginCoordinatorProtocol{
    func goToSignUp()
}
class LoginCoordinator: LoginCoordinatorProtocol{
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func goToSignUp(){
        let signUpViewController = SignUpViewController()
        self.navigationController.pushViewController(signUpViewController, animated: true)
        print("gotosignup - coordinator")
    }
}
