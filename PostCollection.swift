//
//  PostCollection.swift
//  
//
//  Created by 祐一 on 2019/09/12.
//

import FirebaseStorage

protocol PostCollectionDelegate: class {
    func reload()
}

class PostCollection {
    
    static var shared = PostCollection()
    
    public private(set) var posts: [Post] = []
    
    weak var delegate: PostCollectionDelegate?
    
    let postUseCase: PostUseCase
    
    private init() {
        self.postUseCase = PostUseCase()
        self.load()
    }
    
    //    func createShop() -> Shop {
    //        let id = self.shopUseCase.createShopId()
    //        return Shop(id: id, value: [:])
    //    }
    
    // リストの追加
    //    func addShop (_ shop: Shop) {
    //        self.shops.append(shop)
    //        self.shopUseCase.addShop(shop)
    //        self.save()
    //    }
    
    // リストの削除
    //    func removeShop (at: Int) {
    //        let cell = self.shops[at]
    //        self.shopUseCase.removeShop(cell)
    //        self.shops.remove(at: at)
    //        self.save()
    //    }
    
    //    func editShop (_ shop: Shop) {
    //        self.shopUseCase.editShop(shop)
    //        self.save()
    //    }
    
    private func save () {
        self.posts = self.posts.sorted(by: {$0.updateAt.dateValue() > $1.updateAt.dateValue()})
        self.delegate?.reload()
    }
    
    private func load() {
        self.postUseCase.fetchPostDocuments { (posts) in
            guard let _posts = posts else {
                self.save()
                return
            }
            self.posts = _posts
            self.save()
        }
    }
    
    //    func saveImage(image: UIImage?, callback: @escaping ((String?) -> Void)){
    //        self.taskUseCase.saveImage(image: image) { (imageName) in
    //            guard let _ = imageName else {
    //                callback(nil)
    //                return
    //            }
    //            callback(imageName)
    //        }
    //    }
    
    func getImageRef(id: String, imgName: String) -> StorageReference? {
        return self.postUseCase.getImageRef(id: id, imgName: imgName)
    }
}
