//
//  SnapShotDTO.swift
//  Sravel
//
//  Created by asong on 2022/07/13.
//

import Foundation

struct SnapShotDTO: Codable{
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
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case uid = "uid"
        case location = "location"
        case latitude = "latitude"
        case longitude = "longitude"
        case imageUrl = "imageUrl"
        case title = "title"
        case description = "description"
        case hashtag = "hashtag"
        case heartCount = "heartCount"
        case heartCheck = "heartCheck"
        case myTripCount = "mytripCount"
        case myTripCheck = "mytripCheck"
        case hashtag2 = "hashtag2"
        case time = "time"
    }
}
