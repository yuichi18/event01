//
//  ProfileViewController.swift
//  event
//
//  Created by 祐一 on 2019/07/25.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var userNameFieldText: UITextField!
    @IBOutlet weak var genderFieldText: UITextField!
    @IBOutlet weak var ageFieldText: UITextField!
    
    let profileUseCase = ProfileUseCase()
//    let id = Auth.auth().currentUser?.uid
    
    var profile = Profile(value: [:])
//    var didChangeImage = false
    
//    func createprofile() -> Profile {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            fatalError ("Uidを取得出来ませんでした。")
//        }
////        let id = Auth.auth().currentUser?.uid
//        return Profile(id: uid, value: [:])
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerdTappedBtn(_ sender: Any) {
        guard let userName = userNameFieldText.text,
            let gender = genderFieldText.text,
            let age = ageFieldText.text else { return }
        if userName.isEmpty {
            self.singleAlert(title: "エラー", message: "ユーザー名を入力して下さい")
            return
        }
        if gender.isEmpty {
            self.singleAlert(title: "エラー", message: "性別を入力してください")
            return
        }
        if age.isEmpty {
            self.singleAlert(title: "エラー", message: "年齢を入力してください")
            return
        }
        self.profile.userName = userName
        self.profile.gender = gender
        self.profile.age = Int(age)
        
        self.profileUseCase.createProfile(profile)
        self.presentMain(storyboardName: "Main", storyboardId: "MainTabBarController")
    }
    
    func presentMain(storyboardName: String, storyboardId: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let Navi = storyboard.instantiateViewController(withIdentifier: storyboardId)
        self.present(Navi, animated: true, completion: nil)
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
