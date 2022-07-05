//
//  DefaultLoginRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import RxSwift

class DefaultLoginRepository: LoginRepository{
    func loginFirebase(email: String, password: String) -> Observable<Bool> {
        return Observable.create { observable in
            FireStoreDatabase.fireStoreDatabase.loginFirebase(email: email, password: password)
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
