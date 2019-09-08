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
    var selectedClient: Client?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nearStationLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _selectedClient = self.selectedClient{

            self.nameLabel.text = _selectedClient.name
            self.nearStationLabel.text = _selectedClient.nearStation

            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
