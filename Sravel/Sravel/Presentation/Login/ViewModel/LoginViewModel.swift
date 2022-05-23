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
    private let loginUseCase: LoginUseCase
    
    struct Input {
        let emailTextFieldDidEditEvent: Observable<String>
        let passwordTextFieldDidEditEvent: Observable<String>
        let loginButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        var validationErrorMessage = BehaviorRelay<String?>(value: nil)
        var loginButtonShouldEnable = BehaviorRelay<Bool>(value: false)
    }
    
    init(loginUseCase: LoginUseCase){
        self.loginUseCase = loginUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        input.emailTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] email in
                self?.loginUseCase.validate(text: email)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.loginUseCase.emailValidationState
            .subscribe(onNext: { state in
                output.validationErrorMessage.accept(state.description)
                output.loginButtonShouldEnable.accept(state == true)
            })
            .disposed(by: disposeBag)
        
        //self.bindSignUp(from: input, with: output, disposeBag: disposeBag)
        
        return output
    }
    
}
