//
//  ClientCollection.swift
//  event
//
//  Created by 祐一 on 2019/09/08.
//  Copyright © 2019 yuichi. All rights reserved.
//

//import Foundation
import FirebaseStorage

protocol ClientCollectionDelegate: class {
    func reload()
}

class ClientCollection {
    
    static var shared = ClientCollection()
    
    public private(set) var clients: [Client] = []
    
    weak var delegate: ClientCollectionDelegate?
    
    let clientUseCase: ClientUseCase
    
    private init() {
        self.clientUseCase = ClientUseCase()
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
        self.clients = self.clients.sorted(by: {$0.updateAt.dateValue() > $1.updateAt.dateValue()})
        self.delegate?.reload()
    }
    
    private func load() {
        self.clientUseCase.fetchClientDocuments { (clients) in
            guard let _clients = clients else {
                self.save()
                return
            }
            self.clients = _clients
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
        return self.clientUseCase.getImageRef(id: id, imgName: imgName)
        }
}
