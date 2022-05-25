//
//  LoginUseCase.swift
//  Sravel
//
//  Created by asong on 2022/05/23.
//

import Foundation
import RxSwift

class LoginUseCase{
    var email: String = ""
    var password: String = ""
    var passwordValidationState = BehaviorSubject<Bool>(value: false)
    var errorMessage = BehaviorSubject<String>(value: "")
    
    func setEmail(_ text: String){
        self.email = text
    }
    
    func validatePassword(text: String) {
        self.password = text
        self.updateValidationState(of: text)
    }
    
    private func updateValidationState(of passwordText: String) {
        guard !passwordText.isEmpty else {
            self.passwordValidationState.onNext(false)
            return
        }
        guard passwordText.count >= 6 else {
            self.passwordValidationState.onNext(false)
            self.errorMessage.onNext("비밀번호는 6자리 이상으로 입력해주세요.")
            return
        }
        
        self.passwordValidationState.onNext(true)
        self.errorMessage.onNext("")
    }
}
