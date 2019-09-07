//
//  Profile.swift
//  event
//
//  Created by 祐一 on 2019/08/02.
//  Copyright © 2019 yuichi. All rights reserved.
//

//import Foundation

import UIKit
import FirebaseFirestore

class Profile {
//    var id: String
    var userName: String?
    var gender: String?
    var age: Int?
    var imgName: String?
    var createAt: Timestamp
    var updateAt: Timestamp
    
    //初期値設定
    init(value: [String: Any?]) {
//    init(id: String, value: [String: Any?]) {
//        self.id = id
        self.userName = value["userName"] as? String ?? nil
        self.gender = value["gender"] as? String ?? nil
        self.age = value["age"] as? Int ?? nil
        self.imgName = value["imgName"] as? String ?? nil
        self.createAt = value["create_at"] as? Timestamp ?? Timestamp(date: Date())
        self.updateAt = value["update_at"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    //Arrayに変換
    func toValueDict() -> [String: Any] {
        return [
            "userName": self.userName as Any,
            "gender": self.gender as Any,
            "age": self.age as Any,
            "imgName": self.imgName as Any,
            "create_at": self.createAt,
            "update_at": self.updateAt,
        ]
    }
}
