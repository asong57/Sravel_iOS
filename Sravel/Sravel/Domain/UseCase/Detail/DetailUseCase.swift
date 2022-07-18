//
//  DetailUseCase.swift
//  Sravel
//
//  Created by asong on 2022/07/11.
//

import Foundation
import RxSwift

class DetailUseCase{
    
    // MARK: Private Property
    
    private let repository: DetailRepository
    private let disposeBag = DisposeBag()
    
    // MARK: Internal Property
    

    init(repository: DetailRepository){
        self.repository = repository
    }
}
