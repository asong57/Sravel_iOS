//
//  DefaultDetailRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/11.
//

import Foundation
import RxSwift

class DefaultDetailRepository: DetailRepository{
    func getDetailData(latitude: Double, longitude: Double) -> Observable<SnapShotDTO> {
        return Observable.create { observable in
            FireStore.fireStore.getDetailData(latitude: latitude, longitude: longitude)
                .subscribe(onNext: { data in
                    observable.onNext(data)
                })
            return Disposables.create()
        }
    }
}
