//
//  FireStoreDatabase.swift
//  Sravel
//
//  Created by asong on 2022/06/16.
//

import Foundation
import Firebase
import RxSwift

class FireStoreDatabase{
    static let fireStoreDatabase = FireStoreDatabase()
    private init(){}
    
    func loginFirebase(email: String, password: String) -> Single<Bool>{
        return Single<Bool>.create { single in
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                print(user)
                if user != nil{
                    // DatabaseNetwork.shared.setUid()
                    //self.isLoginSuccessed.onNext(true)
                    single(.success(true))
                }else{
                    single(.failure(error!))
                    //self.errorMessage.onNext("로그인에 실패했습니다.")
                }
            }
            return Disposables.create()
        }
    }
}
