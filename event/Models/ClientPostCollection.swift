//
//  ClientPostCollection.swift
//  event
//
//  Created by 祐一 on 2019/09/11.
//  Copyright © 2019 yuichi. All rights reserved.
//
import UIKit
import FirebaseStorage

protocol ClientPostCollectionDelegate: class {
    func reload()
}

class ClientPostCollection {
    
    static var shared = ClientPostCollection()
    
    public private(set) var posts: [ClientPost] = []
    
    weak var delegate: ClientPostCollectionDelegate?
    
    let clientPostUseCase: ClientPostUseCase
    
    private init() {
        self.clientPostUseCase = ClientPostUseCase()
        self.load()
    }
    
    func createPost() -> ClientPost {
        let id = self.clientPostUseCase.createPostId()
        return ClientPost(id: id, value: [:])
    }
    
    // リストの追加
    func addPost (_ post: ClientPost) {
        self.posts.append(post)
        self.clientPostUseCase.addPost(post)
        self.save()
    }
    
    // リストの削除
    func removePost (at: Int) {
        let cell = self.posts[at]
        self.clientPostUseCase.removePost(cell)
        self.posts.remove(at: at)
        self.save()
    }
    
    func editPost (_ post: ClientPost) {
        self.clientPostUseCase.editPost(post)
        self.save()
    }
    
    private func save () {
        self.posts = self.posts.sorted(by: {$0.updateAt.dateValue() > $1.updateAt.dateValue()})
        self.delegate?.reload()
    }
    
    private func load() {
        self.clientPostUseCase.fetchPostDocuments { (posts) in
            guard let _posts = posts else {
                self.save() //Console側とかで空にされたら
                return
            }
            self.posts = _posts
            self.save()
        }
    }
    
        func saveImage(image: UIImage?, callback: @escaping ((String?) -> Void)){
            self.clientPostUseCase.saveImage(image: image) { (imageName) in
                guard let _ = imageName else {
                    callback(nil)
                    return
                }
                callback(imageName)
            }
        }
    
        func getImageRef(imgName: String) -> StorageReference? {
            return self.clientPostUseCase.getImageRef(imgName: imgName)
        }
}

