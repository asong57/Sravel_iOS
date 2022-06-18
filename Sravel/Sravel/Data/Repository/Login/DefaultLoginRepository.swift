//
//  LoginRepository.swift
//  Sravel
//
//  Created by asong on 2022/06/16.
//

import Foundation
import RxSwift

class DefaultLoginRepository: LoginRepository{
    func loginFirebase(email: String, password: String) -> Observable<Bool> {
        return Observable.create { observable in
            FireStoreDatabase.fireStoreDatabase.loginFirebase(email: email, password: password)
                .do(onSuccess: { isSuccessed in
                    observable.onNext(true)
                })
            return Disposables.create()
        }
    }
}
