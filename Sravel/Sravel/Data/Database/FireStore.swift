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
