//
//  UserViewController.swift
//  HowlFirebaseLogin
//
//  Created by 안홍석 on 2020/04/22.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profileUpload(_ sender: Any) {
        let imagePick = UIImagePickerController()
        imagePick.delegate = self
        imagePick.allowsEditing = true
        imagePick.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(imagePick, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage).pngData()
        
        let imageName = Auth.auth().currentUser!.uid + "\(Int(NSDate.timeIntervalSinceReferenceDate * 1000)).jpg"
        
        let riversRef =  Storage.storage().reference().child("ios_images").child(imageName)
        
//        riversRef.putData(image!, metadata: nil) { metadata, error in
//            if (error != nil) {
//
//            } else {
//                let downloadURL = metadata!.downloadURL
//            }
//        }
        
        let uploadTask = riversRef.putData(image!, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
        
        dismiss(animated: true, completion: nil)
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
