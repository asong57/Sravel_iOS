//
//  PlusSnapshotUseCase.swift
//  Sravel
//
//  Created by asong on 2022/07/22.
//

import Foundation
import RxSwift

class PlusSnapshotUseCase {
    
    var title: String = ""
    var description: String = ""
    var hashtag: String = ""
    
    var isPlusMarkerSuccessed = PublishSubject<Bool>()
    
    // MARK: Private Property
    
    private let repository: PlusSnapshotRepository
    private let disposeBag = DisposeBag()
    
    init(repository: PlusSnapshotRepository) {
        self.repository = repository
    }
    
    func setTitle(_ text: String) {
        self.title = text
    }
    
    func setDescription(_ text: String) {
        self.description = text
    }
    
    func setHashtag(_ text: String) {
        self.hashtag = text
    }
    
    func plusSnapshotMarker(){
        repository.plusSnapshotMarkerInfo(markerData: SnapShotDTO(id: "", uid: "", location: "", latitude: 0.0, longitude: 0.0, imageUrl: "", title: title, description: description, hashtag: hashtag, heartCount: 0, heartCheck: ["testUid": true], myTripCount: 0, myTripCheck: ["testUid": true], hashtag2: "", time: ""))
            .subscribe(onNext: { isSuccessed in
                if isSuccessed{
                    self.isPlusMarkerSuccessed.onNext(true)
                }
            }).disposed(by: disposeBag)
    }
}
