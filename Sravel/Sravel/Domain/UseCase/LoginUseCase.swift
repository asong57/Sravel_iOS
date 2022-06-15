//
//  LoginUseCase.swift
//  Sravel
//
//  Created by asong on 2022/05/23.
//

import Foundation
import RxSwift
import Firebase

class LoginUseCase{
    var email: String = ""
    var password: String = ""
    var passwordValidationState = BehaviorSubject<Bool>(value: false)
    var errorMessage = BehaviorSubject<String>(value: "")
    var isLoginSuccessed = PublishSubject<Bool>()
    
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
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil{
                // DatabaseNetwork.shared.setUid()
                self.isLoginSuccessed.onNext(true)
            }else{
                self.errorMessage.onNext("로그인에 실패했습니다.")
            }
        }
    }
}
