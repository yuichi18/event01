//
//  ProfileUseCase.swift
//  event
//
//  Created by 祐一 on 2019/08/02.
//  Copyright © 2019 yuichi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ProfileUseCase {
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    
    //uid取得
//    private func getProfileDocumentRef() -> CollectionReference {
    func getProfileDocumentRef() -> DocumentReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        return
            self.db.collection("users").document(uid)
//            self.db.collection("users").document(uid).collection("profile")
//            self.db.collection("users").document(uid).collection("profile").document("profile")
    }
    
//    func getUid() -> String {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            fatalError ("Uidを取得出来ませんでした。")
//        }
//        return
//            uid
//    }
    
    //
//    func createprofileid() -> Profile {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            fatalError ("Uidを取得出来ませんでした。")
//        }
//        //        let id = Auth.auth().currentUser?.uid
//        return Profile(id: uid, value: [:])
//    }

    
//    let id = self.getUid()
//    var profile = Profile(id: id,value: [:])
    
//    func createTaskId() -> String {
//        let id = self.getProfileDocumentRef().document().documentID
//        print("taskIdは",id)
//        return id
//    }
//    guard let uid = Auth.auth().currentUser?.uid else {return}
    
//    let id = Auth.auth().currentUser?.uid
//    let id = self.getProfileDocumentRef().document().documentID
//    var profile = Profile(id: id, value: [:])
    
    
    //Profile登録
    func createProfile(_ profile: Profile){
        let documentRef = self.getProfileDocumentRef()
//        let documentRef = self.getProfileDocumentRef().document(profile.id)
//        let documentRef = self.getProfileDocumentRef().document()
        documentRef.setData(profile.toValueDict()) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
            }   
        }
    }
    
//    func saveImage(image: UIImage?, callback: @escaping ((String?) -> Void)){
//        guard let image = image, let imageData = image.jpegData(compressionQuality: 0.5),
//            let uid = Auth.auth().currentUser?.uid else { callback(nil)
//                return
//        }
//        //        let imageName = NSUUID().uuidString
//        let imageName = "profile"
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//        let imageRef = storageRef.child(uid).child("\(imageName).jpg")
//        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
//            guard let _ = metadata else { callback(nil)
//                return
//            }
//            callback(imageName)
//        }
//    }
    
//    func getImageRef(imgName: String) -> StorageReference? {
//        guard let uid = Auth.auth().currentUser?.uid
//            else {
//                return nil
//        }
//        let imageRef = storageRef.child(uid).child("\(imgName).jpg")
//        return imageRef
//    }
    
    
    //    func getUserProfile() -> Profile{
    //        let documentRef = self.getProfileDocumentRef()
    //        documentRef.getDocument{ (document, err) in
    //            guard err == nil,
    //                let document = document,document.exists
    //                else {
    //                    print("データ取得失敗",err.debugDescription)
    ////                    callback(nil)
    //                    return
    //                }
    //            print("データ取得")
    //            guard let value = document.data() else {return}
    //            let profile_ = Profile(value: value)
    ////            print(value)
    //        }
    //     return profile
    //    }
    
}
