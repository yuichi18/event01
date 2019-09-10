//
//  ShopCollection.swift
//  event
//
//  Created by 祐一 on 2019/09/06.
//  Copyright © 2019 yuichi. All rights reserved.
//

//import Foundation
//import FirebaseStorage

protocol ShopCollectionDelegate: class {
    func reload()
}

class ShopCollection {
    
    static var shared = ShopCollection()
    
    public private(set) var shops: [Shop] = []
    
    weak var delegate: ShopCollectionDelegate?
    
    let shopUseCase: ShopUseCase
    
    private init() {
        self.shopUseCase = ShopUseCase()
        self.load()
    }
    
    func createShop(_ id: String) -> Shop {
        let id = id
        return Shop(id: id, value: [:])
    }
    
    // リストの追加
    func addShop (_ shop: Shop) {
        self.shops.append(shop)
        self.shopUseCase.addShop(shop)
        self.save()
    }
    
    // リストの削除
    func removeShop (at: Int) {
        let cell = self.shops[at]
        self.shopUseCase.removeShop(cell)
        self.shops.remove(at: at)
        self.save()
    }
    
    func editShop (_ shop: Shop) {
        self.shopUseCase.editShop(shop)
        self.save()
    }
    
    private func save () {
        self.shops = self.shops.sorted(by: {$0.updateAt.dateValue() > $1.updateAt.dateValue()})
        self.delegate?.reload()
    }
    
    private func load() {
        self.shopUseCase.fetchShopDocuments { (shops) in
            guard let _shops = shops else {
                self.save() //Console側とかで空にされたら
                return
            }
            self.shops = _shops
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
    
//    func getImageRef(imgName: String) -> StorageReference? {
//        return self.taskUseCase.getImageRef(imgName: imgName)
//    }
}
