//
//  LoginViewModel.swift
//  Sravel
//
//  Created by asong on 2022/05/17.
//

import Foundation
import RxSwift
import RxRelay

class LoginViewModel {
    private let disposeBag = DisposeBag()
    var input = Input()
    var output = Output()
    
    struct Input {
        let email = PublishSubject<String>()
        let password = PublishSubject<String>()
        let tapSignIn = PublishSubject<Void>()
    }
    
    struct Output {
        let enableSignInButton = PublishRelay<Bool>()
        let errorMessage = PublishRelay<String>()
        let goToMain = PublishRelay<Void>()
    }
    
    init(){
        
    }
}
