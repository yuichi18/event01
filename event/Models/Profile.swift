//
//  Profile.swift
//  event
//
//  Created by 祐一 on 2019/08/02.
//  Copyright © 2019 yuichi. All rights reserved.
//

//import Foundation
class Profile {
    var userName: String?
    var gender: String?
    var age: Int?
//    var imgName: String?
    
    //初期値設定
    init(value: [String: Any?]) {
        self.userName = value["userName"] as? String ?? nil
        self.gender = value["gender"] as? String ?? nil
        self.age = value["age"] as? Int ?? nil
//        self.imgName = value["imgName"] as? String ?? nil
    }
    
    //Arrayに変換
    func toValueDict() -> [String: Any] {
        return [
            "userName": self.userName as Any,
            "gender": self.gender as Any,
            "age": self.age as Any,
//            "imgName": self.imgName as Any,
        ]
    }
}
