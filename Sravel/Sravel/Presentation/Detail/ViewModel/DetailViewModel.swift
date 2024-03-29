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
    private let uid: String = "songUid"

    struct Input {
        let readyToGetDetailData: Observable<Bool>
        let heartButtonDidTapEvent: Observable<Void>
        let downloadButtonDidTapEvent: Observable<Void>
        let deleteButtonDidTapEvent: PublishSubject<Bool>
    }
    
    struct Output {
        var detailMarkerData: PublishSubject<SnapShotDTO> = PublishSubject<SnapShotDTO>()
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
        
        input.heartButtonDidTapEvent
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.detailUseCase.updateHeartCountData()
            }).disposed(by: disposeBag)
        
        input.downloadButtonDidTapEvent
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.detailUseCase.updateDownloadData()
            }).disposed(by: disposeBag)
        
        input.deleteButtonDidTapEvent
            .subscribe(onNext: { [weak self] isTapped in
                guard let self = self else { return }
                if isTapped {
                    self.detailUseCase.deleteSnapshotData()
                }
            }).disposed(by: disposeBag)
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.detailUseCase.detailData
            .subscribe(onNext: { data in
                output.detailMarkerData.onNext(data)
            }).disposed(by: disposeBag)
        
        self.detailUseCase.updateData
            .subscribe(onNext: { data in
                DispatchQueue.main.async {
                    output.detailMarkerData.onNext(data)
                }
            }).disposed(by: disposeBag)
        
        self.detailUseCase.isSucceededDeleting
            .subscribe(onNext: { [weak self] isSucceeded in
                if isSucceeded {
                    self?.coordinator.pop()
                }
            }).disposed(by: disposeBag)
        
        return output
    }
}
