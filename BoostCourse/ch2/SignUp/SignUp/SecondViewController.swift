//
//  SecondViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/02/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwCheckField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addViewsWithCode()
    }
}




// MARK: SecondViewController Methods
extension SecondViewController {
    
    @IBAction func touchUpImage(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        UserInformation.shared.id = nil
        UserInformation.shared.pw = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpNextButton(_ sender: UIButton) {
        
        // id, pw, pwcheck 세 필드 모두 빈문자열 아니고, nil 아닐 때
        guard let idInput = idField.text, !idInput.isEmpty else { return }
        guard let pwInput = pwField.text, !pwInput.isEmpty else { return }
        guard let pwCheck = pwCheckField.text, !pwCheck.isEmpty else { return }
        
        if (pwInput == pwCheck) {
            
            UserInformation.shared.id = idField.text ?? nil
            UserInformation.shared.pw = pwField.text ?? nil
            
            print()
            print("SecondVC -> ThirdVC")
            print("다음 페이지로")
            
            let thirdStoryboard = UIStoryboard(name: "ThirdViewController", bundle: nil)
            let thirdVC = thirdStoryboard.instantiateViewController(withIdentifier: "thirdVC")
            
            self.navigationController?.pushViewController(thirdVC, animated: true)
        }
        else {
            print("pw != check, 다시 입력")
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}




// MARK: imagePicker 델리데이트
extension SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 취소하면 모달 dismiss
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 선택화면
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}




// MARK: SecondViewController Views
extension SecondViewController {
    
    func addViewsWithCode() {
        self.addImageView()
        self.addIdInputField()
        self.addPwInputField()
        self.addPwCheckField()
        self.addTextView()
        self.addCancelButton()
        self.addNextButton()
    }
    
    func addImageView() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        
        image.backgroundColor = .systemGray
        
        image.isUserInteractionEnabled = true
        let clickImageView = UITapGestureRecognizer(target: self, action: #selector(self.touchUpImage(_:)))
        image.addGestureRecognizer(clickImageView)
        
        image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1).isActive = true
        
        self.imageView = image
    }
    
    func addIdInputField() {
        let id: UITextField = UITextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(id)
        
        id.borderStyle = UITextField.BorderStyle.roundedRect
        id.placeholder = "id"
        
        id.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        id.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        id.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        
        self.idField = id
    }
    
    func addPwInputField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.placeholder = "pw"
        // pw.isSecureTextEntry = true
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        pw.topAnchor.constraint(equalTo: idField.bottomAnchor, constant: 8).isActive = true
        
        self.pwField = pw
    }
    
    func addPwCheckField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.placeholder = "check pw"
        pw.isSecureTextEntry = true
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        pw.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 8).isActive = true
        
        self.pwCheckField = pw
    }
    
    func addTextView() {
        let text: UITextView = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(text)
        
        text.isEditable = true
        text.backgroundColor = .systemYellow
        
        text.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        text.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        text.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        // text.heightAnchor.constraint(equalTo: text.widthAnchor, multiplier: 1).isActive = true
        
        self.textView = text
    }
    
    func addCancelButton() {
        let cancel: UIButton = UIButton(type: UIButton.ButtonType.custom)
        
        cancel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cancel)
        
        cancel.setTitle("Cancel", for: UIControl.State.normal)
        
        cancel.addTarget(self, action: #selector(self.touchUpCancelButton(_:)), for: UIControl.Event.touchUpInside)
        
        cancel.backgroundColor = .systemBlue
        
        cancel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80).isActive = true
        cancel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        cancel.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.cancelButton = cancel
        
    }
    
    func addNextButton() {
        let next: UIButton = UIButton(type: UIButton.ButtonType.custom)
        
        next.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(next)
        
        
        next.setTitle("Next", for: UIControl.State.normal)
        
        
        next.addTarget(self, action: #selector(self.touchUpNextButton(_:)), for: UIControl.Event.touchUpInside)
        
        next.backgroundColor = .systemBlue
        
        next.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 80).isActive = true
        next.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        next.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.nextButton = next
    }
}
