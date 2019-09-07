//
//  LoginViewController.swift
//  event
//
//  Created by 祐一 on 2019/07/25.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class LoginViewController: UIViewController,FUIAuthDelegate {
    
    
    @IBOutlet weak var AuthBtn: UIButton!
    @IBOutlet weak var ClientBtn: UIButton!
    var presentProfileIdentification: Int! = 0
    
    
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    // 認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth(),
        FUIFacebookAuth(),
//        FUITwitterAuth(),
        FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // authUIのデリゲート
        self.authUI.delegate = self
        self.authUI.providers = providers
        AuthBtn.addTarget(self,action: #selector(self.AuthButtonTapped(sender:)),for: .touchUpInside)
        ClientBtn.addTarget(self,action: #selector(self.AuthButtonTapped(sender:)),for: .touchUpInside)
    }
    
    @objc func AuthButtonTapped(sender : UIButton) {
//    @objc func AuthButtonTapped(sender : AnyObject) {
        // FirebaseUIのViewの取得
        let authViewController = self.authUI.authViewController()
        // FirebaseUIのViewの表示
        print(sender.tag)
        presentProfileIdentification = sender.tag
        self.present(authViewController, animated: true, completion: nil)
    }
    
    //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // エラー時の処理をここに書く
        if let error = error {
            print((error as NSError).debugDescription)
            return
        }
        // 認証に成功した場合
//        既にログインしている時の遷移を記載する
        if presentProfileIdentification == 0 {
                self.presentProfile()
//                var presentstoryBoardName :String! = "Profile"
//                var presentwithIdentifierName :String! = "toProfileView"
        }
        else {
                self.presentClientProfile()
//                var presentstoryBoardName :String! = "ClientProfile"
//                var presentwithIdentifierName :String! = "toClientProfileView"
        }
//        self.presentProfile(storyBoardName : presentstoryBoardName,withIdentifierName : presentwithIdentifierName)
//        self.presentProfile()
//            self.performSegueProfile()
    }
    
    //遷移
//    func presentProfile(storyBoardName:String!, withIdentifierName:String!) {
//        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
//        let profileNavi = storyboard.instantiateViewController(withIdentifier: withIdentifierName)
//        self.navigationController?.pushViewController(profileNavi, animated: true)
//        //        self.present(profileNavi, animated: true, completion: nil)
//    }
    //Customer
    func presentProfile() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileNavi = storyboard.instantiateViewController(withIdentifier: "toProfileView")
        self.navigationController?.pushViewController(profileNavi, animated: true)
//        self.present(profileNavi, animated: true, completion: nil)
    }

    //Client
    func presentClientProfile() {
        let storyboard = UIStoryboard(name: "ClientProfile", bundle: nil)
        let profileNavi = storyboard.instantiateViewController(withIdentifier: "toClientProfileView")
        self.navigationController?.pushViewController(profileNavi, animated: true)
        //        self.present(profileNavi, animated: true, completion: nil)
    }

    
    //遷移
//    func performSegueProfile(){
//        self.performSegue(withIdentifier: "showToProfileView", sender: nil)
//    }
}
