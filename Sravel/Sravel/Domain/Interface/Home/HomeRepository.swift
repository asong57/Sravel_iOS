//
//  HomeRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/05.
//

import Foundation
import RxSwift

protocol HomeRepository{
    func getMarkersData() -> Observable<[SnapShotDTO]>
    func getMarkersDataWithHashtag(_ hashtag: String) -> Observable<[SnapShotDTO]>
}
