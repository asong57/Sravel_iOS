//
//  PlusSnapshotUseCase.swift
//  Sravel
//
//  Created by asong on 2022/07/22.
//

import Foundation
import RxSwift

class PlusSnapshotUseCase{
    
    // MARK: Private Property
    
    private let repository: PlusSnapshotRepository
    private let disposeBag = DisposeBag()
    
    init(repository: PlusSnapshotRepository){
        self.repository = repository
    }
}
