//
//  HomeUseCase.swift
//  Sravel
//
//  Created by asong on 2022/07/02.
//

import Foundation
import RxSwift

class HomeUseCase{
    private let repository: HomeRepository
    private let disposeBag = DisposeBag()
    
    init(repository: HomeRepository){
        self.repository = repository
    }
}
