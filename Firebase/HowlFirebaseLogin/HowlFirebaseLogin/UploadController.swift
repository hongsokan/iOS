//
//  UploadController.swift
//  HowlFirebaseLogin
//
//  Created by 안홍석 on 2020/05/14.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase

class UploadController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var explanation: UITextField!
    
    @IBAction func uploadButton(_ sender: Any) {
        upload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openGallery)))
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func openGallery() {
        let imagePick = UIImagePickerController()
        imagePick.delegate = self
        imagePick.allowsEditing = true
        imagePick.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(imagePick, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func upload() {
        
        let image = (self.imageView.image!).pngData()
        
        let imageName = Auth.auth().currentUser!.uid + "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000)).jpg"
        
        let riversRef =  Storage.storage().reference().child("ios_images").child(imageName)
        
        riversRef.putData(image!, metadata: nil, completion: {(StorageMetadata, Error) in
            
            riversRef.downloadURL(completion: { (url, err) in
                
                Database.database().reference().child("users").setValue([
                    "userId": Auth.auth().currentUser?.email,
                    "uid": Auth.auth().currentUser?.uid,
                    "subject": self.subject.text!,
                    "explanation": self.explanation.text!,
                    "imageUrl": url?.absoluteString,
                ])
                self.dismiss(animated: true, completion: nil)
            })
        })
        
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
