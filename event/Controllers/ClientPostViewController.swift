//
//  ClientPostViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/11.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI
import PKHUD

class ClientPostViewController: UIViewController {

    let clientPostCollection = ClientPostCollection.shared
    var selectedPost: ClientPost?
    var didChangeImage = false
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextViewField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let _selectedPost = self.selectedPost{
            self.title = "編集投稿画面"
            self.titleTextField.text = _selectedPost.title
            self.detailTextViewField.text = _selectedPost.detail

            if let imageName = _selectedPost.imgName{
                HUD.show(.progress)
                if let ref = self.clientPostCollection.getImageRef(imgName: imageName) {
                    self.imageView.sd_setImage(with: ref, placeholderImage: nil) { (img, err, type, ref) in
                        HUD.hide()
                    }
                }
            }
        } else {
        }
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        super.viewWillAppear(animated)
//        self.configureObserver()
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//
//        super.viewWillDisappear(animated)
//        self.removeObserver() // Notificationを画面が消えるときに削除
//    }
    
    //    キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        outputText.text = inputText.text
        self.view.endEditing(true)
    }
    
    
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
    
    
    @IBAction func didTouchSaveBtn(_ sender: Any) {
        guard let title = titleTextField.text else { return }
        if (title.isEmpty) {
            self.singleAlert(title: "タイトルを入力してください", message: nil)
            return
        }
        
        var post = clientPostCollection.createPost()
        
        if let _selectedPost = self.selectedPost {
            post = _selectedPost
        }
    
        post.title = title
        post.detail = detailTextViewField.text
        
        HUD.show(.progress)
        if self.didChangeImage {
            self.saveImage { (imageName) in
                guard let _imageName = imageName else {
                    self.didFinishSaveImage(post)
                    return
                }
                post.imgName = _imageName
                self.didFinishSaveImage(post)
            }
        } else {
            self.didFinishSaveImage(post)
        }
        
    }
    
    func didFinishSaveImage(_ post: ClientPost){
        HUD.hide()
        self.didChangeImage = false
        if let _ = self.selectedPost {
            post.updateAt = Timestamp(date: Date())
            self.clientPostCollection.editPost(post)
        } else {
            self.clientPostCollection.addPost(post)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveImage(callback: @escaping ((String?) -> Void)){
        guard let image = self.imageView.image else {
            return
        }
        self.clientPostCollection.saveImage(image: image) { (imageName) in
            guard let _imageName = imageName else {
                callback(nil)
                return
            }
            callback(_imageName)
        }
    }


}

extension ClientPostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = pickedImage.resized(toWidth: 300)
            self.didChangeImage = true
        }
        
        //閉じる処理
        picker.dismiss(animated: true, completion: nil)
    }
}
