//
//  SnapShotDTO.swift
//  Sravel
//
//  Created by asong on 2022/07/13.
//

import Foundation

struct SnapShotDTO{
    let id: String
    let uid: String
    let location: String
    let latitude: Double
    let longitude: Double
    let imageUrl: String
    let title: String
    let description: String
    let hashtag: String
    let heartCount: Int
    let heartCheck: [String: Bool]
    let myTripCount: Int
    let myTripCheck: [String: Bool]
    let hashtag2: String
}
