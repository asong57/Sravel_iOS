//
//  SignUpViewModel.swift
//  Sravel
//
//  Created by asong on 2022/06/22.
//

import Foundation
import RxSwift
import RxRelay

class SignUpViewModel {
    private let disposeBag = DisposeBag()
    private let signUpUseCase: SignUpUseCase
    
    struct Input {
        let nameTextFieldDidEditEvent: Observable<String>
        let emailTextFieldDidEditEvent: Observable<String>
        let passwordTextFieldDidEditEvent: Observable<String>
        let passwordForCheckTextFieldDidEditEvent: Observable<String>
        let registerButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        var validationErrorMessage = BehaviorRelay<String?>(value: nil)
        var registerButtonShouldEnable = BehaviorRelay<Bool>(value: false)
        var isRegisterSuccessed = BehaviorRelay<Bool>(value: false)
    }
    
    init(signUpUseCase: SignUpUseCase){
        self.signUpUseCase = signUpUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        
        input.registerButtonDidTapEvent
            .subscribe(onNext: {  _ in
            }).disposed(by: disposeBag)
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        input.nameTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] name in
                guard let self = self else{return}
                self.signUpUseCase.setName(name)
            })
            .disposed(by: disposeBag)
        
        input.emailTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] email in
                guard let self = self else{return}
                self.signUpUseCase.setEmail(email)
            })
            .disposed(by: disposeBag)
        
        input.passwordTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] password in
                guard let self = self else{return}
                self.signUpUseCase.validatePassword(text: password)
            })
            .disposed(by: disposeBag)
        
        input.passwordForCheckTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] password in
                guard let self = self else{return}
                self.signUpUseCase.validatePasswordForCheck(text: password)
            })
            .disposed(by: disposeBag)
        
        input.registerButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else{return}
                self.signUpUseCase.registerUser()
            }).disposed(by: disposeBag)
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.signUpUseCase.passwordValidationState
            .subscribe(onNext: { state in
                output.registerButtonShouldEnable.accept(state == true)
                print(state)
            })
            .disposed(by: disposeBag)
        
        self.signUpUseCase.errorMessage.subscribe(onNext: {message in
            output.validationErrorMessage.accept(message)
        }).disposed(by: disposeBag)
        
        self.signUpUseCase.isRegisterSuccessed.subscribe(onNext: {isSuccessful in
            output.isRegisterSuccessed.accept(isSuccessful == true)
        }).disposed(by: disposeBag)
        
        return output
    }
}

