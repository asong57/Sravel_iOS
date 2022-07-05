//
//  SignUpRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import RxSwift

protocol SignUpRepository{
    func registerUser(name: String, email: String, password: String) -> Observable<Bool>
}
