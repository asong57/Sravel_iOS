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
    
    // MARK: - Internal
    
    var latitude: Double
    var longitude: Double
    
    // MARK: - Private
    
    private var coordinator: DetailFlowCoordinator
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase

    struct Input {
        let readyToGetDetailData: Observable<Bool>
    }
    
    struct Output {
       
    }
    
    init(latitude: Double, longitude: Double, coordinator: DetailFlowCoordinator, detailUseCase: DetailUseCase){
        self.latitude = latitude
        self.longitude = longitude
        self.coordinator = coordinator
        self.detailUseCase = detailUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        input.readyToGetDetailData
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.detailUseCase.getMarkersData(latitude: self.latitude, longitude: self.longitude)
            }).disposed(by: disposeBag)
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        return output
    }
}
