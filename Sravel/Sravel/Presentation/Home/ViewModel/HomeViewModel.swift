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
        let markerSet: Observable<Bool>
    }
    
    struct Output {
        var markersData: PublishSubject<[SnapShotDTO]> = PublishSubject<[SnapShotDTO]>()
    }
    
    init(coordinator: HomeFlowCoordinator, homeUseCase: HomeUseCase){
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input, disposeBag: disposeBag)
        
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input, disposeBag: DisposeBag) {
        input.markerSet
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersData()
            })
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.homeUseCase.markersData
            .subscribe(onNext: { dataArr in
                output.markersData.onNext(dataArr)
                print("HomeViewModel")
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

// MARK: - Marker

extension HomeViewModel{

    func getMarkerDetailData(latitude: Double, longitude: Double){
        self.coordinator.moveToDetailViewController()
    }
}
