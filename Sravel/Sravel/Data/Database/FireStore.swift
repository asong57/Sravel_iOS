//
//  Firestore.swift
//  Sravel
//
//  Created by asong on 2022/07/11.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import RxSwift

class FireStore{
    static let fireStore = FireStore()
    private init(){}
    
    private let db = Firestore.firestore()
    
    func getMarkersLocationSet() -> Observable<[SnapShotDTO]> {
        print("Get Markers 실행됨")
        return Observable.create { [weak self] observable in
            var dataArr: [SnapShotDTO] = []
            self?.db.collection("snapshots").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("FireStore : Error getting documents: \(err)")
                } else {
                    let decoder =  JSONDecoder()
                    for document in querySnapshot!.documents {
                        do {
                            let data = document.data()
                            let jsonData = try JSONSerialization.data(withJSONObject:data)
                            let markerInfo = try decoder.decode(SnapShotDTO.self, from: jsonData)
                            dataArr.append(markerInfo)
                        } catch let err {
                            print("err: \(err)")
                        }
                    }
                    observable.onNext(dataArr)
                }
            }
            return Disposables.create()
        }
    }
    
    func getDetailData(latitude: Double, longitude: Double) -> Observable<SnapShotDTO> {
        return Observable.create { [weak self] observable in
            print("get latitude: \(latitude) longitude: \(longitude)")
            self?.db.collection("snapshots")
                .whereField("latitude", isEqualTo: latitude)
                .whereField("longitude", isEqualTo: longitude)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        let decoder =  JSONDecoder()
                        for document in querySnapshot!.documents {
                            do {
                                let data = document.data()
                                let jsonData = try JSONSerialization.data(withJSONObject:data)
                                let markerInfo = try decoder.decode(SnapShotDTO.self, from: jsonData)
                                print("markerInfo: \(markerInfo)")
                                observable.onNext(markerInfo)
                            } catch let err {
                                print("err: \(err)")
                            }
                        }
                    }
                }
            return Disposables.create()
        }
    }
    
    func plusSnapshotMarker(markerData: SnapShotDTO) -> Observable<Bool> {
        return Observable.create { [weak self] observable in
            do {
                let ref = self?.db.collection("snapshots")
                let id = ref!.document().documentID
                var marker: SnapShotDTO = markerData
                marker.id = id
                try self?.db.collection("snapshots").document(id).setData(marker.dictionary)
                print(marker.dictionary)
                observable.onNext(true)
            } catch let error {
                print("Error writing city to Firestore: \(error)")
            }
            return Disposables.create()
        }
    }
}

extension FireStore {
    func updateHeartCount(id: String, uid: String) -> Observable<SnapShotDTO> {
        return Observable.create { [weak self] observable in
            let reference = self!.db.collection("snapshots").document(id)
            self?.db.runTransaction({ (transaction, errorPointer) -> Any? in
                let sfDocument: DocumentSnapshot
                do {
                    try sfDocument = transaction.getDocument(reference)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
                guard let heartCheck = sfDocument.data()?["heartCheck"] as? [String: Bool], let heartCount = sfDocument.data()?["heartCount"] as? Int, let location =  sfDocument.data()?["location"] as? String, let latitude =  sfDocument.data()?["latitude"] as? Double, let longitude =  sfDocument.data()?["longitude"] as? Double, let imageUrl =  sfDocument.data()?["imageUrl"] as? String, let title =  sfDocument.data()?["title"] as? String, let description =  sfDocument.data()?["description"] as? String, let hashtag =  sfDocument.data()?["hashtag"] as? String, let myTripCount =  sfDocument.data()?["mytripCount"] as? Int, let myTripCheck =  sfDocument.data()?["mytripCheck"] as? [String: Bool], let hashtag2 =  sfDocument.data()?["hashtag2"] as? String, let time =  sfDocument.data()?["time"] as? String else {
                    let error = NSError(
                        domain: "AppErrorDomain",
                        code: -1,
                        userInfo: [
                            NSLocalizedDescriptionKey: "Unable to retrieve population from snapshot \(sfDocument)"
                        ]
                    )
                    errorPointer?.pointee = error
                    return nil
                }
                print("HearCheck : \(heartCheck)")
                var updateHeartCheck = heartCheck
                var updatedHeartCount = heartCount
                if let _ = heartCheck[uid] {
                    updateHeartCheck[uid] = nil
                    updatedHeartCount = heartCount - 1
                    transaction.updateData(["heartCount": updatedHeartCount], forDocument: reference)
                    transaction.updateData(["heartCheck": updateHeartCheck], forDocument: reference)
                    
                } else {
                    updateHeartCheck[uid] = true
                    updatedHeartCount = heartCount + 1
                    transaction.updateData(["heartCount": updatedHeartCount], forDocument: reference)
                    transaction.updateData(["heartCheck": updateHeartCheck], forDocument: reference)
                }
                let updatedDto = SnapShotDTO(id: id, uid: uid, location: location, latitude: latitude, longitude: longitude, imageUrl: imageUrl, title: title, description: description, hashtag: hashtag, heartCount: updatedHeartCount, heartCheck: updateHeartCheck, myTripCount: myTripCount, myTripCheck: myTripCheck, hashtag2: hashtag2, time: time)
                print(updatedDto)
                observable.onNext(updatedDto)
                return nil
            }) { (object, error) in
                if let error = error {
                    print("Transaction failed: \(error)")
                } else {
                    print("Transaction successfully committed!")
                }
            }
            return Disposables.create()
        }
    }
}
