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
    var shopName: String?
    var shopNearStation: String?
    var createAt: Timestamp
    var updateAt: Timestamp
    
    //初期値設定
    init(id: String, value: [String: Any?]) {
        self.id = id
        self.shopName = value["shopName"] as? String ?? nil
        self.shopNearStation = value["shopNearStation"] as? String ?? nil
        self.createAt = value["create_at"] as? Timestamp ?? Timestamp(date: Date())
        self.updateAt = value["update_at"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    //Arrayに変換
    func toValueDict() -> [String: Any] {
        return [
            "shopName": self.shopName as Any,
            "shopNearStation": self.shopNearStation as Any,
            "create_at": self.createAt,
            "update_at": self.updateAt,
        ]
    }
}
