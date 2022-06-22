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
    var coordinator: LoginFlowCoordinator
    private let disposeBag = DisposeBag()
    private let loginUseCase: LoginUseCase
    
    struct Input {
        let emailTextFieldDidEditEvent: Observable<String>
        let passwordTextFieldDidEditEvent: Observable<String>
        let loginButtonDidTapEvent: Observable<Void>
        let registerButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        var validationErrorMessage = BehaviorRelay<String?>(value: nil)
        var loginButtonShouldEnable = BehaviorRelay<Bool>(value: false)
        var isLoginSuccessed = BehaviorRelay<Bool>(value: false)
    }
    
    init(coordinator: LoginFlowCoordinator,loginUseCase: LoginUseCase){
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        
        input.loginButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
            })
        
        input.registerButtonDidTapEvent
            .subscribe(onNext: { [weak self] in
                guard let self = self else{ return }
                self.coordinator.moveToSignUpViewController()
            })
        
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        input.emailTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] email in
                guard let self = self else{return}
                self.loginUseCase.setEmail(email)
            })
            .disposed(by: disposeBag)
        
        input.passwordTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] password in
                guard let self = self else{return}
                self.loginUseCase.validatePassword(text: password)
            })
            .disposed(by: disposeBag)
        
        input.loginButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else{return}
                self.loginUseCase.login()
            })
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.loginUseCase.passwordValidationState
            .subscribe(onNext: { state in
                output.loginButtonShouldEnable.accept(state == true)
                print(state)
            })
            .disposed(by: disposeBag)
        
        self.loginUseCase.errorMessage.subscribe(onNext: {message in
            output.validationErrorMessage.accept(message)
        })
        
        self.loginUseCase.isLoginSuccessed.subscribe(onNext: {isSuccessful in
            output.isLoginSuccessed.accept(isSuccessful == true)
        })
        
        return output
    }
}
