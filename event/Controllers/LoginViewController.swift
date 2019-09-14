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
import FirebaseAuth

class LoginViewController: UIViewController,FUIAuthDelegate {
    
    
    @IBOutlet weak var AuthBtn: UIButton!
    @IBOutlet weak var ClientBtn: UIButton!
    var presentProfileIdentification: Int! = 0
    let db = Firestore.firestore()
    var profileExsistedFlg = false
    
    
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    // 認証に使用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUIEmailAuth(),
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
        
        //プロフィール登録有無チェック
        profileExsistedFlg = checkProfileCreated()
        print(profileExsistedFlg)
//        既にログインしている時の遷移を記載する
        
        if presentProfileIdentification == 0 {
            if profileExsistedFlg == false {
                self.presentProfile()
            }
            else {
                self.presentMain()
            }
        }
        else {
            if profileExsistedFlg == false {
                self.presentClientProfile()
            }
            else {
                self.presentMain()
            }
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
    
    func presentMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileNavi = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
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

//    プロフィール登録有無確認
    func checkProfileCreated() -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        var flg = false
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                flg = true
            } else {
                flg = false
            }
        }
        return flg
    }
    
    
    //遷移
//    func performSegueProfile(){
//        self.performSegue(withIdentifier: "showToProfileView", sender: nil)
//    }
}
