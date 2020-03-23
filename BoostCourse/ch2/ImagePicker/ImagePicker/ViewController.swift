//
//  ViewController.swift
//  ImagePicker
//
//  Created by 안홍석 on 2020/01/29.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        // ViewController가 picker의 델리게이트 역할을 할 것이다 명시
        // delegate 옵션 눌러서 확인해보면 두가지 delegate의 합성 프로토콜
        // 그렇기 때문에 뷰컨트롤러가 두 개의 프로토콜 채택하도록 명시
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpSelectImageButton(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK: imagePicker 델리데이트
    // 취소하면 모달 dismiss
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 선택하면
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // ImagePickerControllerDelegate 문서에서 메서드 확인
        // Getting the Editing Information 에서
        // originalImage를 다양한 키를 통해 받아올 수 있는 방법 확인
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

