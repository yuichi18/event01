//
//  ClientUseCase.swift
//  event
//
//  Created by 祐一 on 2019/09/08.
//  Copyright © 2019 yuichi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ClientProfileUseCase {
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    
    //uid取得
    func getProfileDocumentRef() -> DocumentReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        return
            self.db.collection("clients").document(uid)
    }
    
    //Profile登録
    func createProfile(_ profile: ClientProfile){
        let documentRef = self.getProfileDocumentRef()
        documentRef.setData(profile.toValueDict()) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
            }
        }
    }
    
    //    Profile更新
    func editProfile(_ profile: ClientProfile){
        let documentRef = self.getProfileDocumentRef()
        documentRef.updateData(profile.toValueDict()) { (err) in
            if let _err = err {
                print("データ修正失敗",_err )
            } else {
                print("データ修正成功")
            }
        }
    }
    
    //    写真をCloudStorageに保存
    func saveImage(image: UIImage?, callback: @escaping ((String?) -> Void)){
        guard let image = image, let imageData = image.jpegData(compressionQuality: 0.5),
            let uid = Auth.auth().currentUser?.uid else { callback(nil)
                return
        }
        let imageName = NSUUID().uuidString
        //        let imageName = "profile"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let imageRef = storageRef.child(uid).child("\(imageName).jpg")
        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else { callback(nil)
                return
            }
            callback(imageName)
        }
    }
    
    func getImageRef(imgName: String) -> StorageReference? {
        guard let uid = Auth.auth().currentUser?.uid
            else {
                return nil
        }
        let imageRef = storageRef.child(uid).child("\(imgName).jpg")
        return imageRef
    }
    
    
    //        func getUserProfile() -> Profile {
    //        func getUserProfile(callback: @escaping ([Profile]?) -> Void){
    //            let documentRef = self.getProfileDocumentRef()
    //            documentRef.getDocument{ (document, err) in
    //                guard err == nil,
    //                    let document = document,document.exists
    //                    else {
    //                        print("データ取得失敗",err.debugDescription)
    //    //                    callback(nil)
    //                        return
    //                    }
    //                print("データ取得")
    //                guard let value = document.data() else {return}
    //                let profile = Profile(value: value)
    //                return profile
    //    //            print(value)
    //            }
    //            callback(ProfileViewController)
    ////         return profile
    //        }
    
}
