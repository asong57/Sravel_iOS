//
//  LoginRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import RxSwift

protocol LoginRepository{
    func loginFirebase(email: String, password: String) -> Observable<Bool>
}
