//
//  SignUpUseCase.swift
//  Sravel
//
//  Created by asong on 2022/06/15.
//

import Foundation
import RxSwift

class SignUpUseCase{
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var passwordForCheck: String = ""
    var passwordValidationState = BehaviorSubject<Bool>(value: false)
    var errorMessage = BehaviorSubject<String>(value: "")
    var isRegisterSuccessed = PublishSubject<Bool>()
    private let repository: SignUpRepository
    private let disposeBag = DisposeBag()
    
    init(repository: SignUpRepository){
        self.repository = repository
    }
    
    func setName(_ text: String){
        self.name = text
    }
    
    func setEmail(_ text: String){
        self.email = text
    }
    
    func validatePassword(text: String) {
        self.password = text
        self.updateValidationState()
    }
    
    func validatePasswordForCheck(text: String){
        self.passwordForCheck = text
        self.validatePasswordForCheck()
    }
    
    private func updateValidationState() {
        guard !password.isEmpty else {
            self.passwordValidationState.onNext(false)
            return
        }
        guard password.count >= 6 else {
            self.passwordValidationState.onNext(false)
            self.errorMessage.onNext("비밀번호는 6자리 이상으로 입력해주세요.")
            return
        }
        
        self.passwordValidationState.onNext(true)
        self.errorMessage.onNext("")
    }
    
    private func validatePasswordForCheck(){
        guard password == passwordForCheck else{
            self.passwordValidationState.onNext(false)
            self.errorMessage.onNext("비밀번호를 동일하게 입력해주세요.")
            return
        }
        self.passwordValidationState.onNext(true)
        self.errorMessage.onNext("")
    }
    
    func registerUser(){
        self.repository.registerUser(name: name, email: email, password: password)
            .subscribe(onNext: { isSuccessed in
                if isSuccessed{
                    self.isRegisterSuccessed.onNext(true)
                }
            }, onError: { _ in
                self.errorMessage.onNext("회원가입에 실패했습니다.")
            }).disposed(by: disposeBag)
    }
}
