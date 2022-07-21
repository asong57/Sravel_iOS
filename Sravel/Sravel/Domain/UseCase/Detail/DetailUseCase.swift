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
    
    var detailData = PublishSubject<SnapShotDTO>()

    init(repository: DetailRepository){
        self.repository = repository
    }
    
    func getMarkersData(latitude: Double, longitude: Double){
        repository.getDetailData(latitude: latitude, longitude: longitude)
            .subscribe(onNext: { [weak self] data in
                self?.detailData.onNext(data)
            }).disposed(by: disposeBag)
    }
}
