//
//  ClientProfileViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/07.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import PKHUD

class ClientProfileViewController: UIViewController {

    
    @IBOutlet weak var clientNameFieldText: UITextField!
    @IBOutlet weak var nearStationNameFieldText: UITextField!
    @IBOutlet weak var hpFieldText: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    let clientProfileUseCase = ClientProfileUseCase()
    var clientProfile = ClientProfile(value: [:])
    var selectedClientProfile: ClientProfile?
//    var selectedProfile: ClientProfile?
    var didChangeImage = false
//    var uiimagename: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        
        
        let documentRef = self.clientProfileUseCase.getProfileDocumentRef()
        documentRef.getDocument{ (document, err) in
            guard err == nil,
                let document = document else {
                    print("データ取得失敗",err.debugDescription)
                    return
            }
            print("データ取得")
            guard let value = document.data() else {return}
            //            print(value)
            let selectedClientProfile = ClientProfile(value: value)
            
//            guard let userName = selectedProfile.na else {return}
            guard let name = selectedClientProfile.name else {return}
            self.clientNameFieldText.text = name
            guard let nearStation = selectedClientProfile.nearStation else {return}
            self.nearStationNameFieldText.text = nearStation
            guard let hp = selectedClientProfile.hp else {return}
            self.hpFieldText.text = hp
            if let imageName = selectedClientProfile.imgName{
                //                HUD.show(.progress)
                if let ref = self.clientProfileUseCase.getImageRef(imgName: imageName) {
                    self.profileImageView.sd_setImage(with: ref, placeholderImage: nil) { (img, err, type, ref) in
                        HUD.hide()
                        //                        self.uiimagename=selectedProfile.imgName!
                        self.clientProfile.imgName=selectedClientProfile.imgName!
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.configureObserver()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.removeObserver() // Notificationを画面が消えるときに削除
    }
    
    //    キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        outputText.text = inputText.text
        self.view.endEditing(true)
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
    @IBAction func registerdClientTappedBtn(_ sender: Any) {
        guard let name = clientNameFieldText.text,
            let nearStation = nearStationNameFieldText.text,
            let hp = hpFieldText.text else { return }
        if name.isEmpty {
            self.singleAlert(title: "エラー", message: "お店の名前を入力して下さい")
            return
        }
        if nearStation.isEmpty {
            self.singleAlert(title: "エラー", message: "お店の最寄り駅を入力してください")
            return
        }
        //        if hp.isEmpty {
        //            self.singleAlert(title: "エラー", message: "ホームページを入力してください")
        //            return
        //        }
        self.clientProfile.name = name
        self.clientProfile.nearStation = nearStation
        self.clientProfile.hp = hp
        
        if self.didChangeImage {
            self.saveImage { (imageName) in
                guard let _imageName = imageName else {
                    self.didFinishSaveImage(self.clientProfile)
                    return
                }
                self.clientProfile.imgName = _imageName
                self.didFinishSaveImage(self.clientProfile)
            }
        } else {
            self.didFinishSaveImage(clientProfile)
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
        self.clientProfileUseCase.saveImage(image: image) { (imageName) in
            guard let _imageName = imageName else { callback(nil)
                return
            }
            callback(_imageName)
        }
    }
    
    func didFinishSaveImage(_ profile: ClientProfile){
        //        HUD.hide()
        self.didChangeImage = false
        if let _ = self.selectedClientProfile {
            profile.updateAt = Timestamp(date: Date())
            self.clientProfileUseCase.editProfile(clientProfile)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.clientProfileUseCase.createProfile(clientProfile)
            self.presentMain(storyboardName: "ClientMain", storyboardId: "ClientMainTabBarController")
        }
        
        //        self.profileUseCase.createProfile(profile)
        //        self.presentMain(storyboardName: "Main", storyboardId: "MainTabBarController")
        //        self.navigationController?.popViewController(animated: true)
    }
//    @IBAction func registerdTappedBtn(_ sender: Any) {

}

extension ClientProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
            self.profileImageView.contentMode = .scaleAspectFill
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
