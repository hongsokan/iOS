//
//  SecondViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/02/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    private weak var uiView: UIView!
    private weak var imageView: UIImageView!
    private weak var stackView: UIStackView!
    private weak var idField: UITextField!
    private weak var pwField: UITextField!
    private weak var pwCheckField: UITextField!
    private weak var textView: UITextView!
    private weak var cancelButton: UIButton!
    private weak var nextButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        
        textView.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 다음 화면으로 갔다가 이전으로 다시 돌아오는 경우
        // 저장된 id, pw, text 입력된 상태로 돌아옴
        if UserInformation.shared.id != nil {
            idField.text = UserInformation.shared.id
        }
        
        if UserInformation.shared.pw != nil {
            pwField.text = UserInformation.shared.pw
        }
        
        if UserInformation.shared.pw != nil {
            pwCheckField.text = UserInformation.shared.pw
        }
        
        if UserInformation.shared.text != nil {
            textView.text = UserInformation.shared.text
        }
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}




// MARK: SecondViewController Methods
extension SecondViewController {
    
    @objc func touchUpImage(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func touchUpCancelButton(_ sender: UIButton) {
        UserInformation.shared.id = nil
        UserInformation.shared.pw = nil
        UserInformation.shared.text = nil
        UserInformation.shared.phone = nil
        UserInformation.shared.birth = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func touchUpNextButton(_ sender: UIButton) {
        
        // id, pw, pwcheck 세 필드 모두 빈문자열 아니고, nil 아닐 때
        guard let idInput = idField.text, !idInput.isEmpty else { return }
        guard let pwInput = pwField.text, !pwInput.isEmpty else { return }
        guard let pwCheck = pwCheckField.text, !pwCheck.isEmpty else { return }
        
        if (pwInput == pwCheck) {
            
            UserInformation.shared.id = idField.text ?? nil
            UserInformation.shared.pw = pwField.text ?? nil
            UserInformation.shared.text = textView.text ?? nil
            
            let thirdStoryboard = UIStoryboard(name: "ThirdViewController", bundle: nil)
            let thirdVC = thirdStoryboard.instantiateViewController(withIdentifier: "thirdVC")
            
            self.navigationController?.pushViewController(thirdVC, animated: true)
        }
        else {
            print("Password != Password Check, 다시 입력")
            
            let message: String = "Password와 Password Check이 일치하지 않습니다."
            
            let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
                
                self.navigationController?.popViewController(animated: false)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    
    // 이미지 선택하면 next 버튼 활성 여부 체크
    @objc func imageSelected(_ sender: UIImageView) {
        if (self.imageView.image != nil) && (self.idField.hasText) && (self.pwField.hasText) && (self.pwCheckField.hasText) && (self.textView.hasText) &&
            (self.pwField.text == self.pwCheckField.text) {
            nextButton.setTitleColor(.systemBlue, for: .normal)
            nextButton.isUserInteractionEnabled = true
        }
        // print("check if image selected")
    }
    
    
    // id, pw, pwCheck 3가지 TextField 입력하면 next 버튼 활성 여부 체크
    @objc func textFieldDidChange(_ sender: UITextField) {
        if (self.imageView.image != nil) && (self.idField.hasText) && (self.pwField.hasText) && (self.pwCheckField.hasText) && (self.textView.hasText) &&
            (self.pwField.text == self.pwCheckField.text) {
            nextButton.setTitleColor(.systemBlue, for: .normal)
            nextButton.isUserInteractionEnabled = true
        }
        // print("check if textField changed")
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
            imageSelected(self.imageView)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}




// MARK: textView 델리데이트
extension SecondViewController: UITextViewDelegate {
    
    // textView 입력하면 next 버튼 활성 여부 체크
    func textViewDidChange(_ textView: UITextView) {
        if (self.imageView.image != nil) && (self.idField.hasText) && (self.pwField.hasText) && (self.pwCheckField.hasText) && (self.textView.hasText) &&
            (self.pwField.text == self.pwCheckField.text) {
            nextButton.setTitleColor(.systemBlue, for: .normal)
            nextButton.isUserInteractionEnabled = true
        }
        // print("check if textView changed")
    }
}




// MARK: SecondViewController Views
extension SecondViewController {
    
    func addViews() {
        self.addUIView()
        self.addImageView()
        self.addIdInputField()
        self.addPwInputField()
        self.addPwCheckField()
        self.addStackView()
        self.addTextView()
        self.addCancelButton()
        self.addNextButton()
    }
    
    func addUIView() {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.uiView = view
    }
    
    func addImageView() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        
        image.backgroundColor = .systemGray
        
        image.isUserInteractionEnabled = true
        let clickImageView = UITapGestureRecognizer(target: self, action: #selector(self.touchUpImage(_:)))
        image.addGestureRecognizer(clickImageView)
        
        image.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor, constant: 8).isActive = true
        image.topAnchor.constraint(equalTo: self.uiView.topAnchor, constant: 32).isActive = true
        image.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.3).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1).isActive = true
        
        self.imageView = image
    }
    
    func addIdInputField() {
        let id: UITextField = UITextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(id)
        
        id.borderStyle = UITextField.BorderStyle.roundedRect
        id.placeholder = "ID"
        
        id.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        id.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        id.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        
        self.idField = id
    }
    
    func addPwInputField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.placeholder = "Password"
        pw.isSecureTextEntry = true
        
        pw.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        
        self.pwField = pw
    }
    
    func addPwCheckField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.placeholder = "Password Check"
        pw.isSecureTextEntry = true
        
        pw.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        pw.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        
        self.pwCheckField = pw
    }
    
    func addStackView() {
        let stack: UIStackView = UIStackView(arrangedSubviews: [self.idField, self.pwField, self.pwCheckField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(stack)
        
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        
        stack.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 8).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        
        self.stackView = stack
    }
    
    func addTextView() {
        let text: UITextView = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(text)
        
        text.isEditable = true
        text.backgroundColor = .systemYellow
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        
        text.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor, constant: 8).isActive = true
        text.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -8).isActive = true
        text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        text.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        
        self.textView = text
    }
    
    func addCancelButton() {
        let cancel: UIButton = UIButton(type: UIButton.ButtonType.custom)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cancel)
        
        cancel.backgroundColor = .none
        cancel.setTitle("취소", for: UIControl.State.normal)
        cancel.setTitleColor(.systemRed, for: .normal)
        
        cancel.addTarget(self, action: #selector(self.touchUpCancelButton(_:)), for: UIControl.Event.touchUpInside)
        
        cancel.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor, constant: 16).isActive = true
        cancel.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.45).isActive = true
        cancel.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.cancelButton = cancel
        
    }
    
    func addNextButton() {
        let next: UIButton = UIButton(type: UIButton.ButtonType.custom)
        next.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(next)
        
        next.backgroundColor = .none
        next.setTitle("다음", for: UIControl.State.normal)
        next.setTitleColor(.systemGray, for: .normal)
        next.isUserInteractionEnabled = false
        
        next.addTarget(self, action: #selector(self.touchUpNextButton(_:)), for: UIControl.Event.touchUpInside)
        
        next.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -16).isActive = true
        next.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.45).isActive = true
        next.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 16).isActive = true
        
        self.nextButton = next
    }
}
