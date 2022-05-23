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
    var emailValidationState = BehaviorSubject<Bool>(value: false)
    
    func validate(text: String) {
        self.email = text
        self.updateValidationState(of: text)
    }
    
    private func updateValidationState(of emailText: String) {
        guard !emailText.isEmpty else {
            self.emailValidationState.onNext(false)
            return
        }
        guard emailText.count >= 5 else {
            self.emailValidationState.onNext(false)
            return
        }
        guard emailText.count <= 20 else {
            self.emailValidationState.onNext(false)
            return
        }
        guard emailText.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil else {
            self.emailValidationState.onNext(false)
            return
        }
        
        self.emailValidationState.onNext(true)
    }
}
