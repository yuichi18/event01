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
    }
    
    @objc func AuthButtonTapped(sender : AnyObject) {
        // FirebaseUIのViewの取得
        let authViewController = self.authUI.authViewController()
        // FirebaseUIのViewの表示
        self.present(authViewController, animated: true, completion: nil)
    }
    
    //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // 認証に成功した場合
        if error == nil {
//            self.performSegue(withIdentifier: "toTopView", sender: self)
            self.presentProfile()
//            self.performSegueProfile()

        }
    
        // エラー時の処理をここに書く
    }
    
    //遷移
    func presentProfile() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileNavi = storyboard.instantiateViewController(withIdentifier: "toProfileView")
        self.present(profileNavi, animated: true, completion: nil)
    }

//    func presentProfile() {
//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        let profileNavi = storyboard.instantiateViewController(withIdentifier: "toProfileView")
//        self.present(profileNavi, animated: true, completion: nil)
//    }
    
    
    //遷移
    func performSegueProfile(){
        self.performSegue(withIdentifier: "showToProfileView", sender: nil)
    }
}
