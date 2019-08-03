//
//  AlertViewController.swift
//  event
//
//  Created by 祐一 on 2019/07/26.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit

extension UIViewController {
    func singleAlert(title: String, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
