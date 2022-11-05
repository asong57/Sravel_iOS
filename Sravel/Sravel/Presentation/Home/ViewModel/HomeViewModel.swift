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
        let plusButtonDidTapEvent: Observable<Void>
        let searchButtonDidTapEvent: Observable<Void>
        let streetButtonDidTapEvent: Observable<Void>
        let skyButtonDidTapEvent: Observable<Void>
        let oceanButtonDidTapEvent: Observable<Void>
        let natureButtonDidTapEvent: Observable<Void>
        let animalButtonDidTapEvent: Observable<Void>
        let landmarkButtonDidTapEvent: Observable<Void>
        let foodButtonDidTapEvent: Observable<Void>
        let countryButtonDidTapEvent: Observable<Void>
        let cityButtonDidTapEvent: Observable<Void>
        let etcButtonDidTapEvent: Observable<Void>
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
            }).disposed(by: disposeBag)
        
        input.plusButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.moveToPlusSnapshotViewController()
            }).disposed(by: disposeBag)
        
        input.searchButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.moveToHomeSearchViewController()
            }).disposed(by: disposeBag)
        
        input.streetButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#거리")
            }).disposed(by: disposeBag)
        
        input.skyButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#하늘")
            }).disposed(by: disposeBag)
        
        input.oceanButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#바다")
            }).disposed(by: disposeBag)
        
        input.natureButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#자연")
            }).disposed(by: disposeBag)
        
        input.animalButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#동물")
            }).disposed(by: disposeBag)
        
        input.landmarkButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#명소")
            }).disposed(by: disposeBag)
        
        input.foodButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#음식")
            }).disposed(by: disposeBag)
        
        input.countryButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#시골")
            }).disposed(by: disposeBag)
        
        input.cityButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#도시")
            }).disposed(by: disposeBag)
        
        input.etcButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.homeUseCase.getMarkersDataWithHashtag("#기타")
            }).disposed(by: disposeBag)
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
        self.coordinator.moveToDetailViewController(latitude: latitude, longitude: longitude)
    }
}
