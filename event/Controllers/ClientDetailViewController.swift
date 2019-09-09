//
//  ClientDetailViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/08.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI
import PKHUD

class ClientDetailViewController: UIViewController {

    let clientCollection = ClientCollection.shared
    let shopCollection = ShopCollection.shared
    var selectedClient: Client?
    var selectedShop: Shop?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nearStationLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _selectedClient = self.selectedClient{

            self.nameLabel.text = _selectedClient.name
            self.nearStationLabel.text = _selectedClient.nearStation
            self.hpLabel.text = _selectedClient.hp
            
            if let imageName = _selectedClient.imgName{
                let id = _selectedClient.id
                HUD.show(.progress)
                if let ref = self.clientCollection.getImageRef(id: id, imgName: imageName) {
                    self.clientImageView.sd_setImage(with: ref, placeholderImage: nil) { (img, err, type, ref) in
                        HUD.hide()
                    }
                }
            }
        } else {
//            self.configureLocationManager()
        }
//        self.configureGoogleMap()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTouchSaveBtn(_ sender: Any) {
        
        let shop = shopCollection.createShop()
        
        shop.shopName = nameLabel.text
        shop.shopNearStation = nearStationLabel.text
        
        self.shopCollection.addShop(shop)
//        if let _ = self.selectedShop {
//            shop.updateAt = Timestamp(date: Date())
//            self.shopCollection.editShop(shop)
//        } else {
//            self.shopCollection.addShop(shop)
//        }
//        self.navigationController?.popViewController(animated: true)
        // pop 2 view controllers
//        self.navigationController?.popViewControllers(viewsToPop: 2)
        self.presentMainTable()
    }
    
    func presentMainTable() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileNavi = storyboard.instantiateViewController(withIdentifier: "toMainTableView")
        self.navigationController?.pushViewController(profileNavi, animated: true)
        //        self.present(profileNavi, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
