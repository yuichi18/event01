////
////  MainPostViewController.swift
////  event
////
////  Created by 祐一 on 2019/09/12.
////  Copyright © 2019 yuichi. All rights reserved.
////
//
//import UIKit
//
//import UIKit
//import FirebaseFirestore
//import FirebaseUI
//import PKHUD
//
//class MainPostViewController: UIViewController {
//    
//    let clientPostCollection = ClientPostCollection.shared
//    var selectedClientPost: ClientPost?
//    var uiImageViewName: String?
//    var id: String = ""
//    
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var detailLabel: UILabel!
//    @IBOutlet weak var ImageView: UIImageView!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //        お店一覧から遷移した場合
//        if let _selectedClientPost = self.selectedClientPost{
//            
//            self.saveBtn.isEnabled = true
//            
//            self.id = _selectedClientPost.id
//            self.titleLabel.text = _selectedClientPost.title
//            self.detailLabel.text = _selectedClientPost.detail
//            self.uiImageViewName = _selectedClientPost.imgName
//            
//            if let imageName = _selectedClientPost.imgName{
//                let id = _selectedClientPost.id
//                HUD.show(.progress)
//                if let ref = self.clientPostCollection.getImageRef(id: id, imgName: imageName) {
//                    self.uiImageViewName.sd_setImage(with: ref, placeholderImage: nil) { (img, err, type, ref) in
//                        HUD.hide()
//                    }
//                }
//            }
//            
//            //        MYお店一覧から遷移した場合
//            //            あとで関数化
////        } else if let _selectedShop = self.selectedShop {
////
////            self.saveBtn.isEnabled = false
////
////            self.id = _selectedShop.id
////            self.nameLabel.text = _selectedShop.shopName
////            self.nearStationLabel.text = _selectedShop.shopNearStation
////            self.hpLabel.text = _selectedShop.shopHp
////            self.uiImageViewName = _selectedShop.imgName
////
////            if let imageName = _selectedShop.imgName{
////                let id = _selectedShop.id
////                HUD.show(.progress)
////                if let ref = self.clientCollection.getImageRef(id: id, imgName: imageName) {
////                    self.clientImageView.sd_setImage(with: ref, placeholderImage: nil) { (img, err, type, ref) in
////                        HUD.hide()
////                    }
////                }
////            }
////            //            self.configureLocationManager()
////        }
//        
//        //        self.configureGoogleMap()
//        // Do any additional setup after loading the view.
//    }
//    
////    @IBAction func didTouchSaveBtn(_ sender: Any) {
////
////        let shop = shopCollection.createShop(id)
////
////        shop.shopName = nameLabel.text
////        shop.shopNearStation = nearStationLabel.text
////        shop.shopHp = hpLabel.text
////        shop.imgName = uiImageViewName
////
////        self.shopCollection.addShop(shop)
////        //        if let _ = self.selectedShop {
////        //            shop.updateAt = Timestamp(date: Date())
////        //            self.shopCollection.editShop(shop)
////        //        } else {
////        //            self.shopCollection.addShop(shop)
////        //        }
////        //        self.navigationController?.popViewController(animated: true)
////        // pop 2 view controllers
////        //        self.navigationController?.popViewControllers(viewsToPop: 2)
////        self.presentMainTable()
////    }
////
////    func presentMainTable() {
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        let Navi = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
////        //        self.navigationController?.pushViewController(profileNavi, animated: true)
////        //        self.present(Navi, animated: true, completion: nil)
////        self.present(Navi, animated: true, completion: nil)
////    }
//    
//    
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    
//}
