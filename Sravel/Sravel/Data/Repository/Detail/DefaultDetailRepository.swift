//
//  DefaultDetailRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/11.
//

import Foundation
import RxSwift

class DefaultDetailRepository: DetailRepository{
    private var disposeBag = DisposeBag()
    private let serialQueue = DispatchQueue(label: "updateSerialQueue")
    
    func getDetailData(latitude: Double, longitude: Double) -> Observable<SnapShotDTO> {
        return Observable.create { [weak self] observable in
            FireStore.fireStore.getDetailData(latitude: latitude, longitude: longitude)
                .subscribe(onNext: { data in
                    observable.onNext(data)
                }).disposed(by: self!.disposeBag)
            return Disposables.create()
        }
    }
    
    func updateHeartCount(id: String, uid: String) -> Observable<SnapShotDTO> {
        return Observable.create { [weak self] observable in
            self?.serialQueue.async {
                FireStore.fireStore.updateMarkerData(id: id, uid: uid, isHeartUpdated: true, isDownloadUpdated: false)
                    .subscribe(onNext: { data in
                        observable.onNext(data)
                    }).disposed(by: self!.disposeBag)
            }
            return Disposables.create()
        }
    }
    
    func updateDownloadCount(id: String, uid: String) -> Observable<SnapShotDTO> {
        return Observable.create { [weak self] observable in
            self?.serialQueue.async {
                FireStore.fireStore.updateMarkerData(id: id, uid: uid, isHeartUpdated: false, isDownloadUpdated: true)
                    .subscribe(onNext: { data in
                        observable.onNext(data)
                    }).disposed(by: self!.disposeBag)
            }
            return Disposables.create()
        }
    }
    
    func deleteSnapshotData(id: String, uid: String) -> Observable<Bool> {
        return Observable.create { [weak self] observable in
            self?.serialQueue.async {
                FireStore.fireStore.deleteSnapshotMarker(id: id, uid: uid)
                    .subscribe(onNext: { isDeletedSucceded in
                        observable.onNext(isDeletedSucceded)
                    }).disposed(by: self!.disposeBag)
            }
            return Disposables.create()
        }
    }
}
