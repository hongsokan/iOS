//
//  ViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/08/28.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    private weak var uiView: UIView!
    var uiViewConstraint = NSLayoutConstraint()
    weak var idField: UITextField!
    weak var pwField: UITextField!
    private weak var imageView: UIImageView!
    private weak var signinButton: UIButton!
    private weak var signupButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addViews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserInformation.shared.id != nil {
            idField?.text = UserInformation.shared.id
        }
        
        if UserInformation.shared.pw != nil {
            pwField?.text = UserInformation.shared.pw
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isPortrait {
            // print("portrait")
            uiViewConstraint.isActive = false
            uiViewConstraint = self.uiView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
            uiViewConstraint.isActive = true
        } else if UIDevice.current.orientation.isLandscape {
            // print("landscape")
            uiViewConstraint.isActive = false
            uiViewConstraint = self.uiView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
            uiViewConstraint.isActive = true
        }
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}




// MARK: ViewController Methods
extension SignInViewController {
    
    @objc func touchUpImage(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func touchUpSignInButton(_ sender: UIButton) {
        // id, pw 두 필드가 빈문자열이 아니고, nil 이 아닐 때
        guard let idInput = idField.text, !idInput.isEmpty else { return }
        guard let pwInput = pwField.text, !pwInput.isEmpty else { return }
        
        if (idField.text == UserInformation.shared.id) && (pwField.text == UserInformation.shared.pw) {
            print("로그인 성공")
            
            // 로그인 성공 시 다음 화면으로
            let musicStoryboard: UIStoryboard = UIStoryboard(name: "MusicViewController", bundle: nil)
            let music = musicStoryboard.instantiateViewController(withIdentifier: "musicVC") as! MusicViewController
            
            // 네비게이션 추가
            let naviController = UINavigationController(rootViewController: music)
            self.present(naviController, animated: true, completion: nil)
            
        } else {
            print("로그인 실패")
            
            // 실패 시 애니메이션 효과 추가
            UIView.animate(withDuration: 0.2, animations: {
                self.idField.frame.origin.x -= 10
                self.pwField.frame.origin.x -= 10
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.idField.frame.origin.x += 20
                    self.pwField.frame.origin.x += 20
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.idField.frame.origin.x -= 10
                        self.pwField.frame.origin.x -= 10
                    })
                })
            })
        }
    }
    
    
    @objc func touchUpSignUpButton(_ sender: UIButton) {
        
        let secondStoryboard = UIStoryboard(name: "SecondViewController", bundle: nil)
        
        let secondVC = secondStoryboard.instantiateViewController(withIdentifier: "secondVC")
        
        let navigationController = UINavigationController(rootViewController: secondVC)
        navigationController.setNavigationBarHidden(true, animated: true)
        
        // print("MainVC -> SecondVC")
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToMain (segue: UIStoryboardSegue) {
        if (idField.text == UserInformation.shared.id) && (pwField.text == UserInformation.shared.pw) {
            signinButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if idField.isFirstResponder {
            pwField.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if (idField.text == UserInformation.shared.id) && (pwField.text == UserInformation.shared.pw) {
            signinButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
}




// MARK: imagePicker 델리데이트
extension SignInViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
}




// MARK: ViewController Views
extension SignInViewController {
    
    func addViews() {
        self.addView()
        self.addImageView()
        self.addIdTextField()
        self.addPwTextField()
        self.addSignInButton()
        self.addSignUpButton()
    }
    
    
    func addView() {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        
        self.uiView = view
    }
    
    
    func addImageView() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(image)
        
        image.backgroundColor = .none
        image.image = UIImage(named: "icon")
        
        image.centerXAnchor.constraint(equalTo: self.uiView.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.uiView.topAnchor, constant: 32).isActive = true
        image.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1).isActive = true
        
        self.imageView = image
    }
    
    
    func addIdTextField() {
        let id: UITextField = UITextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(id)
        
        id.borderStyle = UITextField.BorderStyle.roundedRect
        id.placeholder = "ID"
        
        id.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        id.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        id.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor).isActive = true
        id.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor).isActive = true
        id.centerXAnchor.constraint(equalTo: self.uiView.centerXAnchor).isActive = true
        id.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 32).isActive = true
        
        self.idField = id
    }
    
    
    func addPwTextField() {
        let pw: UITextField = UITextField()
        pw.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(pw)
        
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.placeholder = "Password"
        pw.isSecureTextEntry = true
        
        pw.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        pw.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        pw.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor).isActive = true
        pw.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor).isActive = true
        pw.centerXAnchor.constraint(equalTo: self.uiView.centerXAnchor).isActive = true
        pw.topAnchor.constraint(equalTo: self.idField.bottomAnchor, constant: 16).isActive = true
        
        self.pwField = pw
    }
    
    
    func addSignInButton() {
        let signin: UIButton = UIButton(type: UIButton.ButtonType.custom)
        signin.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(signin)
        
        signin.setTitle("SignIn", for: UIControl.State.normal)
        
        signin.addTarget(self, action: #selector(self.touchUpSignInButton(_:)), for: UIControl.Event.touchUpInside)
        
        signin.backgroundColor = .none
        signin.setTitleColor(.systemGray, for: .normal)
        
        signin.topAnchor.constraint(equalTo: self.pwField.bottomAnchor, constant: 32).isActive = true
        signin.leadingAnchor.constraint(equalTo: pwField.leadingAnchor, constant: 16).isActive = true
        signin.trailingAnchor.constraint(equalTo: pwField.centerXAnchor, constant: -16).isActive = true
        
        self.signinButton = signin
    }
    
    
    func addSignUpButton() {
        let signup: UIButton = UIButton(type: UIButton.ButtonType.custom)
        signup.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(signup)
        
        signup.setTitle("SignUp", for: UIControl.State.normal)
        
        signup.addTarget(self, action: #selector(didEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        signup.addTarget(self, action: #selector(self.touchUpSignUpButton(_:)), for: UIControl.Event.touchUpInside)
        
        signup.backgroundColor = .none
        signup.setTitleColor(.systemRed, for: .normal)
        
        signup.topAnchor.constraint(equalTo: self.pwField.bottomAnchor, constant: 32).isActive = true
        signup.trailingAnchor.constraint(equalTo: pwField.trailingAnchor, constant: -16).isActive = true
        signup.leadingAnchor.constraint(equalTo: pwField.centerXAnchor, constant: 16).isActive = true
        
        self.signupButton = signup
    }
}
