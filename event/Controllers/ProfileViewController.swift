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
import PKHUD

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var userNameFieldText: UITextField!
    @IBOutlet weak var genderFieldText: UITextField!
    @IBOutlet weak var ageFieldText: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let profileUseCase = ProfileUseCase()
    var profile = Profile(value: [:])
    var selectedProfile: Profile?
    var didChangeImage = false
    var uiimagename: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        
        
        let documentRef = self.profileUseCase.getProfileDocumentRef()
        documentRef.getDocument{ (document, err) in
            guard err == nil,
                let document = document else {
                    print("データ取得失敗",err.debugDescription)
                    return
            }
            print("データ取得")
            guard let value = document.data() else {return}
            //            print(value)
            let selectedProfile = Profile(value: value)
            
            guard let userName = selectedProfile.userName else {return}
            self.userNameFieldText.text = userName
            guard let gender = selectedProfile.gender else {return}
            self.genderFieldText.text = String(gender)
            guard let age = selectedProfile.age else {return}
            self.ageFieldText.text = String(age)
            if let imageName = selectedProfile.imgName{
                //                HUD.show(.progress)
                if let ref = self.profileUseCase.getImageRef(imgName: imageName) {
                    self.profileImageView.sd_setImage(with: ref, placeholderImage: nil) { (img, err, type, ref) in
                        HUD.hide()
                        //                        self.uiimagename=selectedProfile.imgName!
                        self.profile.imgName=selectedProfile.imgName!
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
//    画像タッチ後処理
    @IBAction func didTouchImage(_ sender: Any) {
        
        let alert = UIAlertController(title:"", message: "選択してください", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "カメラで撮影", style: .default, handler: {
            (action: UIAlertAction!) in
            self.presentPicker(souceType: .camera)
            
        }))
        alert.addAction(UIAlertAction(title: "アルバムから選択", style: .default, handler: {
            (action: UIAlertAction!) in
            self.presentPicker(souceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
//    保存ボタン押下時処理
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
        
        if self.didChangeImage {
            self.saveImage { (imageName) in
                guard let _imageName = imageName else {
                    self.didFinishSaveImage(self.profile)
                    return
                }
                self.profile.imgName = _imageName
                self.didFinishSaveImage(self.profile)
            }
        } else {
            self.didFinishSaveImage(profile)
        }
        //        self.profileUseCase.createProfile(profile)
        //        self.presentMain(storyboardName: "Main", storyboardId: "MainTabBarController")
    }
    
    func presentMain(storyboardName: String, storyboardId: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let Navi = storyboard.instantiateViewController(withIdentifier: storyboardId)
        self.present(Navi, animated: true, completion: nil)
    }
    
//    画像保存
    func saveImage(callback: @escaping ((String?) -> Void)){ guard let image = self.profileImageView.image else {
        return
        }
        self.profileUseCase.saveImage(image: image) { (imageName) in
            guard let _imageName = imageName else { callback(nil)
                return
            }
            callback(_imageName)
        }
    }
    
    func didFinishSaveImage(_ profile: Profile){
        //        HUD.hide()
        self.didChangeImage = false
        if let _ = self.selectedProfile {
            profile.updateAt = Timestamp(date: Date())
            self.profileUseCase.editProfile(profile)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.profileUseCase.createProfile(profile)
            self.presentMain(storyboardName: "Main", storyboardId: "MainTabBarController")
        }
        
        //        self.profileUseCase.createProfile(profile)
        //        self.presentMain(storyboardName: "Main", storyboardId: "MainTabBarController")
        //        self.navigationController?.popViewController(animated: true)
    }
    
//    ログアウト処理
//    @IBAction func logoutTappedBtn(_ sender: Any) {
//        do {
//            try Auth.auth().signOut()
//            let storyboard = UIStoryboard(name: "Login", bundle: nil)
//            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
//            let appDelegate = AppDelegate.shared
//            appDelegate.window?.rootViewController = loginVC
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
    
    
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func presentPicker (souceType:UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(souceType) {
            let picker = UIImagePickerController()
            picker.sourceType = souceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        } else {
            print ("The SouceType is not found.")
        }
    }
    
    //　撮影もしくは画像を選択したら呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.profileImageView.contentMode = .scaleAspectFit
            self.profileImageView.image = pickedImage.resized(toWidth: 500)
            self.didChangeImage = true
        }
        
        //閉じる処理
        picker.dismiss(animated: true, completion: nil)
    }
}

//写真をリサイズ
//extension UIImage {
//    func resized(toWidth width: CGFloat) -> UIImage? {
//        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//}
