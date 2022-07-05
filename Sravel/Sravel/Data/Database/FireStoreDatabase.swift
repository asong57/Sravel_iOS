//
//  FireStoreDatabase.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import Firebase
import RxSwift

class FireStoreDatabase{
    static let fireStoreDatabase = FireStoreDatabase()
    private init(){}
    
    func loginFirebase(email: String, password: String) -> Observable<Bool>{
        return Observable.create{observer -> Disposable in
            observer.onNext(true)
            // 일단 다른 로직들 다 구현 후 돌려놓기
            /*
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if user != nil{
                    // DatabaseNetwork.shared.setUid()
                    observer.onNext(true)
                }else{
                    observer.onNext(false)
                }
            }*/
            return Disposables.create()
        }
    }
    
    func registerUserInfo(name: String, email: String, password: String) -> Observable<Bool>{
        return Observable.create{observer -> Disposable in
            // 회원가입 로직 추가
                observer.onNext(true)
            return Disposables.create()
        }
    }
}
