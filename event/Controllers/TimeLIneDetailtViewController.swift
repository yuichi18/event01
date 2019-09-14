//
//  TimeLIneDetailViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/12.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI
import PKHUD

class TimeLIneDetailViewController: UIViewController {
    
    let postCollection = PostCollection.shared
    var selectedPost: Post?
//    var uiImageViewName: String?
//    var id: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        お店一覧から遷移した場合
        if let _selectedPost = self.selectedPost{
            
//            self.id = _selectedPost.id
            self.titleLabel.text = _selectedPost.title
            self.detailLabel.text = _selectedPost.detail
//            self.uiImageViewName = _selectedClientPost.imgName
            
            if let imageName = _selectedPost.imgName{
//                let id = _selectedClientPost.id
                HUD.show(.progress)
                if let ref = self.postCollection.getImageRef(imgName: imageName) {
//                    self.clientPostCollection.getImageRef(id: id, imgName: imageName) {
                    self.ImageView.sd_setImage(with: ref, placeholderImage: nil) { (img, err, type, ref) in
                        HUD.hide()
                    }
                }
            }
            
        }
        
    }
}
