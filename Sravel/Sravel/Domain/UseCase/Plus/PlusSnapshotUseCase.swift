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
        
    }
}
