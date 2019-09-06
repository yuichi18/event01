//
//  ShopSearchViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/06.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI

class ShopSearchViewController: UIViewController {
    
    let shopCollection = ShopCollection.shared

    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var shopNearStationTextField: UITextField!
    
    var selectedShop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTouchSaveBtn(_ sender: Any) {
        guard let shopName = shopNameTextField.text else { return }
        if (shopName.isEmpty) {
            self.singleAlert(title: "お店の名前を入力してください", message: nil)
            return
        }
        
        var shop = shopCollection.createShop()
        
        if let _selectedShop = self.selectedShop {
            shop = _selectedShop
        }
        
        shop.shopName = shopName
        shop.shopNearStation = shopNearStationTextField.text
        
        if let _ = self.selectedShop {
            shop.updateAt = Timestamp(date: Date())
            self.shopCollection.editShop(shop)
        } else {
            self.shopCollection.addShop(shop)
        }
        self.navigationController?.popViewController(animated: true)
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
