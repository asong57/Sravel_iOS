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
    
    func loginFirebase(email: String, password: String) -> Observable<Bool>{
        return Observable.create{observer -> Disposable in
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if user != nil{
                    // DatabaseNetwork.shared.setUid()
                    observer.onNext(true)
                }else{
                    observer.onNext(false)
                }
            }
            return Disposables.create()
        }
    }
}
