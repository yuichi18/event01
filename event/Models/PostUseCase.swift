//
//  PostUseCase.swift
//  event
//
//  Created by 祐一 on 2019/09/12.
//  Copyright © 2019 yuichi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class PostUseCase {
    
    //    クライアントコレクションを接続先に設定する
//    let collectionRef = Firestore.firestore().collection("clients").
//    let postCollection: PostCollection
    let db = Firestore.firestore()
    var getposts: [Post] = []
    private func getCollectionRef () -> CollectionReference {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        return self.db.collection("users").document(uid).collection("shops")
    }
    
//    let db = Firestore.firestore()
//    private func getCollectionRef () -> CollectionReference {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            fatalError ("Uidを取得出来ませんでした。")
//        }
//        return self.db.collection("client").document(uid).collection("posts")
//    }
    
//        func createShopId() -> String {
//            let id = self.getCollectionRef().document().documentID
//            return id
//        }
    //
    //    func addShop(_ shop: Shop){
    //        let documentRef = self.getCollectionRef().document(shop.id)
    //        documentRef.setData(shop.toValueDict()) { (err) in
    //            if let _err = err {
    //                print("データ追加失敗",_err)
    //            } else {
    //                print("データ追加成功")
    //            }
    //        }
    //    }
    //
    //    func editShop(_ shop: Shop){
    //        let documentRef = self.getCollectionRef().document(shop.id)
    //        documentRef.updateData(shop.toValueDict()) { (err) in
    //            if let _err = err {
    //                print("データ修正失敗",_err)
    //            } else {
    //                print("データ修正成功")
    //            }
    //        }
    //    }
    //
    //    func removeShop(_ shop: Shop){
    //        let documentRef = self.getCollectionRef().document(shop.id)
    //        documentRef.delete { (err) in
    //            if let _err = err {
    //                print("データ取得",_err)
    //            } else {
    //                print("データ削除成功")
    //                //                if let imgName = task.imgName {
    //                //                    self.deleteImage(imgName: imgName)
    //                //                }
    //            }
    //        }
    //    }

//    func fetchPostDocuments(callback: @escaping ([Post]?) -> Void){
    func fetchPostDocuments() -> [Post]{
//        var posts: [Post] = []
//        let post:Post
        let collectionRef = getCollectionRef()
//        collectionRef.addSnapshotListener { (snapshot, err) in
                    collectionRef.getDocuments(source: .default) { (snapshot, err) in
            guard err == nil,
                let _snapshot = snapshot,
                !_snapshot.isEmpty else {
                    print("データ取得失敗",err.debugDescription)
                    //                    callback(nil)
                    return
            }
            print("clientデータ取得成功")
            //            let postCollection: [Post]
            
//            var posts: [Post] = []
//            var post:Post
            
            for document in snapshot!.documents {
                print("\(document.documentID) => \(document.data())")
                let clientID = document.documentID
                print(clientID)
                let postcollectionRef = self.db.collection("clients").document(clientID).collection("posts")
//                postcollectionRef.addSnapshotListener { (querySnapshot, err) in
                                    postcollectionRef.getDocuments(source: .default) { (querySnapshot, err) in
                    guard err == nil,
                        let _querysnapshot = querySnapshot,
                        !_querysnapshot.isEmpty else {
                            print("データ取得失敗",err.debugDescription)
                            //                            callback(nil)
                            return
                    }
                    print("postデータ取得成功")
                    
                    
                    for postdocument in _querysnapshot.documents {
                        let post = Post(value:[:])
                        post.id = postdocument.documentID
                        //                        post.value = postdocument.data()
                        var postValue = postdocument.data()
                        post.title = postValue["title"] as? String
                        post.detail = postValue["detail"] as? String
                        post.imgName = postValue["imgName"] as? String
//                        post.createAt = postValue["createAt"] as? Timestamp
//                        post.updateAt = postValue["updateAt"] as? Timestamp
                        self.getposts.append(post)
                    }
                    
                    //                    let postCollection: [Post] = _querysnapshot.documents.compactMap{ (snapshot) in
                    //                        let id = snapshot.documentID
                    //                        let value = snapshot.data()
                    //
                    //                        return Post(id :id ,value: value)
                    //                    }
                }
            }
        }
            return getposts
        //                callback(PostCollection)
    }

    
//
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        var posts:[PostCollection.Post] = []
//                        let postCollection: [Post] = []
//                        for document in querySnapshot!.documents {
//                            print("\(accountName): \(document.documentID) => \(document.data())")
//                            let post = try! FirestoreDecoder().decode(INDX01FirestoreService.PortfolioItem.self, from: document.data())
//
//                            items.append(pi )
//
//                                        let postCollection: [Post] = _snapshot.documents.compactMap{ (snapshot) in
//                                            let id = snapshot.documentID
//                                            let value = snapshot.data()
//                                            return Post(id :id ,value: value)
//                                        }
//                                        callback(postCollection)
                    
                
           
//            let postCollection: [Post] = _snapshot.documents.compactMap{ (snapshot) in
//                let id = snapshot.documentID
//                let value = snapshot.data()
//                return Post(id :id ,value: value)
//            }
//            callback(postCollection)

    
//    func fetchPostDocuments(callback: @escaping ([Post]?) -> Void){
//        let collectionRef = getCollectionRef()
//        collectionRef.getDocuments(source: .default) { (snapshot, err) in
//            guard err == nil,
//                let _snapshot = snapshot,
//                !_snapshot.isEmpty else {
//                    print("データ取得失敗",err.debugDescription)
//                    callback(nil)
//                    return
//            }
//            print("データ取得成功")
//            let postCollection: [Post] = _snapshot.documents.compactMap{ (snapshot) in
//                let id = snapshot.documentID
//                let value = snapshot.data()
//                return Post(id :id ,value: value)
//            }
//            callback(postCollection)
//        }
//    }

    let storageRef = Storage.storage().reference()

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

//    func getImageRef(id: String, imgName: String) -> StorageReference? {
//        //            guard let uid = Auth.auth().currentUser?.uid else {
//        //                return nil
//        //            }
//        let imageRef = storageRef.child(id).child("\(imgName).jpg")
//        return imageRef
//    }
    
    func getImageRef(imgName: String) -> StorageReference? {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        let imageRef = storageRef.child(uid).child("\(imgName).jpg")
        return imageRef
    }
}
