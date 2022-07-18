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
                        //print("FireStore: \(document.documentID) => \(document.data())")
                    }
                    observable.onNext(dataArr)
                }
            }
            return Disposables.create()
        }
    }
}
