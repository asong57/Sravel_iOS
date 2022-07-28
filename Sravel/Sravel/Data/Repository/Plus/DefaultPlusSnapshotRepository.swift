//
//  DefaultPlusSnapshotRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/22.
//

import Foundation
import RxSwift

class DefaultPlusSnapshotRepository: PlusSnapshotRepository {
    func plusSnapshotMarkerInfo(markerData: SnapShotDTO) -> Observable<Bool> {
        return Observable.create { observable in
            FireStore.fireStore.plusSnapshotMarker(markerData: markerData)
                .subscribe(onNext: { isSuccessed in
                    if isSuccessed{
                        observable.onNext(true)
                    }
                })
            return Disposables.create()
        }
    }
}

                           
