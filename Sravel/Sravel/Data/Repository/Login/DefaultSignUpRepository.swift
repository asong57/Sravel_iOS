//
//  DefaultSignUpRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import RxSwift

class DefaultSignUpRepository: SignUpRepository{
    func registerUser(name: String, email: String, password: String) -> Observable<Bool> {
        return Observable.create { observable in
            FireStoreDatabase.fireStoreDatabase.registerUserInfo(name: name, email: email, password: password)
                .subscribe(onNext: { isSuccessed in
                    if isSuccessed{
                        observable.onNext(true)
                    }
                }
                )
            return Disposables.create()
        }
    }
}
