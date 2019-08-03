//
//  Login.swift
//  event
//
//  Created by 祐一 on 2019/07/27.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import Firebase

class Login: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpTappedBtn(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passTextField.text else { return }
        if email.isEmpty {
            self.singleAlert(title: "エラー", message: "メールアドレスを入力して下さい")
            return
        }
        if password.isEmpty {
            self.singleAlert(title: "エラー", message: "パスワードを入力して下さい")
            return
        }
        
        self.emailSignUp(email: email, password: password)
    }
    
    
    @IBAction func signInTappedBtn(_ sender: Any) {
        guard let email = emailTextField.text,
            let password = passTextField.text else { return }
        if email.isEmpty {
            self.singleAlert(title: "エラー", message: "メールアドレスを入力して下さい")
            return
        }
        if password.isEmpty {
            self.singleAlert(title: "エラー", message: "パスワードを入力して下さい")
            return
        }
        
        self.emailSignIn(email: email, password: password)
    }
    
    func emailSignUp (email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let _error = error {
                self.signUpErrAlert(_error)
            } else {
                self.presentPlofile()
            }
        }
    }
    
    func emailSignIn (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _error = error {
                self.signInErrAlert(_error)
            } else {
//                self.performSegue(withIdentifier: "toTopView", sender: self)
                self.presentPlofile()
            }
        }
    }
    
    func signUpErrAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .invalidEmail:      message =  "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse: message = "既に登録されているメールアドレスです"
            case .weakPassword:      message = "パスワードは６文字以上で入力してください"
            default:                 message = "エラー: \(error.localizedDescription)"
            }
            self.singleAlert(title: "登録できません", message: message)
        }
    }
    
    func signInErrAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .userNotFound:  message = "アカウントが見つかりませんでした"
            case .wrongPassword: message = "パスワードを確認してください"
            case .userDisabled:  message = "アカウントが無効になっています"
            case .invalidEmail:  message = "Eメールが無効な形式です"
            default:             message = "エラー: \(error.localizedDescription)"
            }
            self.singleAlert(title: "ログインできません", message: message)
        }
    }
    
    
    func presentPlofile() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let taskNavi = storyboard.instantiateViewController(withIdentifier: "toProfileView")
//        toProfileView
//        ProfileViewController
        self.present(taskNavi, animated: true, completion: nil)
    }
    
//    @IBAction func termsTappedBtn(_ sender: Any) {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsViewController") {
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
