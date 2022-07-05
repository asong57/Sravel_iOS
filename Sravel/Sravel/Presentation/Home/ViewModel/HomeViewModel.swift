//
//  HomeViewModel.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
    var coordinator: HomeFlowCoordinator
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCase
    
    struct Input {
    }
    
    struct Output {
        var validationErrorMessage = BehaviorRelay<String?>(value: nil)
        var loginButtonShouldEnable = BehaviorRelay<Bool>(value: false)
        var isLoginSuccessed = BehaviorRelay<Bool>(value: false)
    }
    
    init(coordinator: HomeFlowCoordinator,homeUseCase: HomeUseCase){
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
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
