//
//  Post.swift
//  event
//
//  Created by 祐一 on 2019/09/12.
//  Copyright © 2019 yuichi. All rights reserved.
//

import FirebaseFirestore

class Post {
//    var id: String
    var id: String?
    var title: String?
    var detail: String?
    var imgName: String?
    var createAt: Timestamp
    var updateAt: Timestamp
    
    //初期値設定
//    init(id: String, value: [String: Any?]) {
    init(value: [String: Any?]) {
//        self.id = id
        self.id = value["id"] as? String ?? nil
        self.title = value["title"] as? String ?? nil
        self.detail = value["detail"] as? String ?? nil
        self.imgName = value["imgName"] as? String ?? nil
        self.createAt = value["create_at"] as? Timestamp ?? Timestamp(date: Date())
        self.updateAt = value["update_at"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    //Arrayに変換
    func toValueDict() -> [String: Any] {
        return [
            "id": self.id as Any,
            "title": self.title as Any,
            "detail": self.detail as Any,
            "imgName": self.imgName as Any,
            "create_at": self.createAt,
            "update_at": self.updateAt,
        ]
    }
}
