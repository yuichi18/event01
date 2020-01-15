//
//  Client.swift
//  event
//
//  Created by 祐一 on 2019/09/08.
//  Copyright © 2019 yuichi. All rights reserved.
//

//import Foundation
import FirebaseFirestore

class Client {
    var id: String
    var name: String?
    var nearStation: String?
    var hp: String?
    var imgName: String?
    var createAt: Timestamp
    var updateAt: Timestamp
    
    //初期値設定
    init(id: String, value: [String: Any?]) {
        self.id = id
        self.name = value["name"] as? String ?? nil
        self.nearStation = value["nearStation"] as? String ?? nil
        self.hp = value["hp"] as? String ?? nil
        self.imgName = value["imgName"] as? String ?? nil
        self.createAt = value["create_at"] as? Timestamp ?? Timestamp(date: Date())
        self.updateAt = value["update_at"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    //Arrayに変換
    func toValueDict() -> [String: Any] {
        return [
            "name": self.name as Any,
            "nearStation": self.nearStation as Any,
            "hp": self.hp as Any,
            "imgName": self.imgName as Any,
            "create_at": self.createAt,
            "update_at": self.updateAt,
        ]
    }
}
