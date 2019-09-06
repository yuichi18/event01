//
//  ShopUseCase.swift
//  event
//
//  Created by 祐一 on 2019/09/06.
//  Copyright © 2019 yuichi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ShopUseCase {
    
    let db = Firestore.firestore()
    
    // ユーザー毎のデータベースへの参照を取得する
    private func getCollectionRef () -> CollectionReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        return self.db.collection("users").document(uid).collection("shops")
    }
    
    func createShopId() -> String {
        let id = self.getCollectionRef().document().documentID
        return id
    }
    
    func addShop(_ shop: Shop){
        let documentRef = self.getCollectionRef().document(shop.id)
        documentRef.setData(shop.toValueDict()) { (err) in
            if let _err = err {
                print("データ追加失敗",_err)
            } else {
                print("データ追加成功")
            }
        }
    }
    
    func editShop(_ shop: Shop){
        let documentRef = self.getCollectionRef().document(shop.id)
        documentRef.updateData(shop.toValueDict()) { (err) in
            if let _err = err {
                print("データ修正失敗",_err)
            } else {
                print("データ修正成功")
            }
        }
    }
    
    func removeShop(_ shop: Shop){
        let documentRef = self.getCollectionRef().document(shop.id)
        documentRef.delete { (err) in
            if let _err = err {
                print("データ取得",_err)
            } else {
                print("データ削除成功")
//                if let imgName = task.imgName {
//                    self.deleteImage(imgName: imgName)
//                }
            }
        }
    }
    
    
    
    func fetchShopDocuments(callback: @escaping ([Shop]?) -> Void){
        let collectionRef = getCollectionRef()
        collectionRef.getDocuments(source: .default) { (snapshot, err) in
            guard err == nil,
                let _snapshot = snapshot,
                !_snapshot.isEmpty else {
                    print("データ取得失敗",err.debugDescription)
                    callback(nil)
                    return
            }
            
            print("データ取得成功")
            
            let shopCollection: [Shop] = _snapshot.documents.compactMap{ (snapshot) in
                let id = snapshot.documentID
                let value = snapshot.data()
                return Shop(id :id ,value: value)
            }
            
            callback(shopCollection)
        }
    }
    
//    let storageRef = Storage.storage().reference()
    
//    func saveImage(image: UIImage?, callback: @escaping ((String?) -> Void)){
//        guard let image = image,
//            let imageData = image.jpegData(compressionQuality: 0.5),
//            let uid = Auth.auth().currentUser?.uid else {
//                callback(nil)
//                return
//        }
//        let imageName = NSUUID().uuidString
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//        let imageRef = storageRef.child(uid).child("\(imageName).jpg")
//        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
//            guard let _ = metadata else {
//                print ("画像アップエラーです",error.debugDescription)
//                callback(nil)
//                return
//            }
//            callback(imageName)
//        }
//    }
    
//    func deleteImage(imgName: String){
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//        let imageRef = storageRef.child(uid).child("\(imgName).jpg")
//        imageRef.delete { (err) in
//            if let _ = err {
//                print("画像削除エラーです",err.debugDescription)
//            } else {
//                print("画像削除成功です")
//            }
//        }
//    }
    
//    func getImageRef(imgName: String) -> StorageReference? {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return nil
//        }
//        let imageRef = storageRef.child(uid).child("\(imgName).jpg")
//        return imageRef
//    }
}
