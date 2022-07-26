//
//  PlusSnapshotViewModel.swift
//  Sravel
//
//  Created by asong on 2022/07/22.
//

import Foundation
import RxSwift
import RxRelay

class PlusSnapshotViewModel {
    var coordinator: PlusSnapshotFlowCoordinator
    private let disposeBag = DisposeBag()
    private let plusSnapshotUseCase: PlusSnapshotUseCase
    
    struct Input {
        let titleTextFieldDidEditEvent: Observable<String>
        let descriptionTextFieldDidEditEvent: Observable<String>
        let hashtagTextFieldDidEditEvent: Observable<String>
        let submitButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
       
    }
    
    init(coordinator: PlusSnapshotFlowCoordinator, plusSnapshotUseCase: PlusSnapshotUseCase){
        self.coordinator = coordinator
        self.plusSnapshotUseCase = plusSnapshotUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        input.titleTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] title in
                self?.plusSnapshotUseCase.setTitle(title)
            }).disposed(by: disposeBag)
        
        input.descriptionTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] text in
                self?.plusSnapshotUseCase.setDescription(text)
            }).disposed(by: disposeBag)
        
        input.hashtagTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] text in
                self?.plusSnapshotUseCase.setHashtag(text)
            }).disposed(by: disposeBag)
        
        input.submitButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.plusSnapshotUseCase.plusSnapshotMarker()
            }).disposed(by: disposeBag)
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        
        return output
    }
}
