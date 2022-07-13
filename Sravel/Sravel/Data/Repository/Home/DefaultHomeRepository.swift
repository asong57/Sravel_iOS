//
//  DefaultHomeRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/13.
//

import Foundation
import RxSwift

class DefaultHomeRepository: HomeRepository{
    func getMarkersData() -> Observable<[SnapShotDTO]> {
        return Observable.create { observable in
            FireStore.fireStore.getMarkersLocationSet()
                .subscribe(onNext: { dataArr in
                    observable.onNext(dataArr)
                })
            return Disposables.create()
        }
    }
}
