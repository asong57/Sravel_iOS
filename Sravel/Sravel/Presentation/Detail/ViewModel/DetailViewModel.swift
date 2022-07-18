//
//  DetailViewModel.swift
//  Sravel
//
//  Created by asong on 2022/07/11.
//

import Foundation
import RxSwift
import RxRelay

class DetailViewModel {
    var coordinator: DetailFlowCoordinator
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase
    
    struct Input {
       
    }
    
    struct Output {
       
    }
    
    init(coordinator: DetailFlowCoordinator, detailUseCase: DetailUseCase){
        self.coordinator = coordinator
        self.detailUseCase = detailUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        return output
    }
}
