//
//  DetailRepository.swift
//  Sravel
//
//  Created by asong on 2022/07/11.
//

import Foundation
import RxSwift

protocol DetailRepository{
    func getDetailData(latitude: Double, longitude: Double) -> Observable<SnapShotDTO>
    func updateHeartCount(id: String, uid: String) -> Observable<SnapShotDTO>
}
