//
//  DetailUseCase.swift
//  Sravel
//
//  Created by asong on 2022/07/11.
//

import Foundation
import RxSwift

class DetailUseCase {
    
    // MARK: Private Property
    
    private let repository: DetailRepository
    private let disposeBag = DisposeBag()
    private var id: String = ""
    private var uid: String = "songUid"
    
    // MARK: Internal Property
    
    var detailData = PublishSubject<SnapShotDTO>()
    var updateData = PublishSubject<SnapShotDTO>()
    var isSucceededDeleting = PublishSubject<Bool>()

    init(repository: DetailRepository ){
        self.repository = repository
    }
    
    func getMarkersData(latitude: Double, longitude: Double) {
        repository.getDetailData(latitude: latitude, longitude: longitude)
            .subscribe(onNext: { [weak self] data in
                self?.detailData.onNext(data)
                self?.id = data.id
            }).disposed(by: disposeBag)
    }
    
    func updateHeartCountData() {
        repository.updateHeartCount(id: id, uid: uid)
            .subscribe(onNext: { [weak self] data in
                self?.updateData.onNext(data)
            }).disposed(by: disposeBag)
    }
    
    func updateDownloadData() {
        repository.updateDownloadCount(id: id, uid: uid)
            .subscribe(onNext: { [weak self] data in
                self?.updateData.onNext(data)
            }).disposed(by: disposeBag)
    }
    
    func deleteSnapshotData() {
        repository.deleteSnapshotData(id: id, uid: uid)
            .subscribe(onNext: { [weak self] isSucceeded in
                self?.isSucceededDeleting.onNext(isSucceeded)
            }).disposed(by: disposeBag)
    }
}
