//
//  Shop.swift
//  event
//
//  Created by 祐一 on 2019/09/06.
//  Copyright © 2019 yuichi. All rights reserved.
//

//import Foundation

import UIKit
import FirebaseFirestore

class Shop {
    var id: String
//    var id: String?
    var shopName: String?
    var shopNearStation: String?
    var shopHp: String?
    var imgName: String?
    var createAt: Timestamp
    var updateAt: Timestamp
    
    //初期値設定
    init(id: String, value: [String: Any?]) {
//    init(value: [String: Any?]) {
        self.id = id
//        self.id = value["id"] as? String ?? nil
        self.shopName = value["shopName"] as? String ?? nil
        self.shopNearStation = value["shopNearStation"] as? String ?? nil
        self.shopHp = value["shopHp"] as? String ?? nil
        self.imgName = value["imgName"] as? String ?? nil
        self.createAt = value["create_at"] as? Timestamp ?? Timestamp(date: Date())
        self.updateAt = value["update_at"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    //Arrayに変換
    func toValueDict() -> [String: Any] {
        return [
//            "id": self.id as Any,
            "shopName": self.shopName as Any,
            "shopNearStation": self.shopNearStation as Any,
            "shopHp": self.shopHp as Any,
            "imgName": self.imgName as Any,
            "create_at": self.createAt,
            "update_at": self.updateAt,
        ]
    }
}
