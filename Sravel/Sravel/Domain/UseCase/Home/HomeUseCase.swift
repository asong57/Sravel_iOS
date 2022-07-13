//
//  HomeUseCase.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import RxSwift

class HomeUseCase{
    
    // MARK: Private Property
    
    private let repository: HomeRepository
    private let disposeBag = DisposeBag()
    
    // MARK: Internal Property
    
    var markersData = PublishSubject<[SnapShotDTO]>()
    
    init(repository: HomeRepository){
        self.repository = repository
    }
    
    func getMarkersData(){
        repository.getMarkersData()
            .subscribe(onNext: { [weak self] dataArr in
                self?.markersData.onNext(dataArr)
            }).disposed(by: disposeBag)
    }
}
