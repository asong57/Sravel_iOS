//
//  SnapShotDTO.swift
//  Sravel
//
//  Created by asong on 2022/07/13.
//

import Foundation

public struct SnapShotDTO: Codable{
    var id: String
    let uid: String
    let location: String
    let latitude: Double
    let longitude: Double
    let imageUrl: String
    let title: String
    let description: String
    let hashtag: String
    var heartCount: Int
    var heartCheck: [String: Bool]
    var myTripCount: Int
    var myTripCheck: [String: Bool]
    let hashtag2: String
    let time: String
    
    var dictionary: [String: Any] {
        return ["id": id,
                "uid": uid,
                "location": location,
                "latitude": latitude,
                "longitude": longitude,
                "imageUrl": imageUrl,
                "title": title,
                "description": description,
                "hashtag": hashtag,
                "heartCount": heartCount,
                "heartCheck": heartCheck,
                "mytripCount": myTripCount,
                "mytripCheck": myTripCheck,
                "hashtag2": hashtag2,
                "time": time]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
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
