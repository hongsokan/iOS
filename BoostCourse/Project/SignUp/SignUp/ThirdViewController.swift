//
//  ThirdViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/02/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    private weak var uiView: UIView!
    private weak var phoneLabel: UILabel!
    private weak var phoneField: UITextField!
    private weak var birthLabel: UILabel!
    private weak var birthDisplay: UILabel!
    private weak var birthPicker: UIDatePicker!
    private weak var cancelButton: UIButton!
    private weak var prevButton: UIButton!
    private weak var doneButton: UIButton!
    
    var datePickerHeight: NSLayoutConstraint!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        formatter.dateStyle = .medium
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.addViews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserInformation.shared.phone != nil {
            phoneField.text = UserInformation.shared.phone
        }
        
        if UserInformation.shared.birth != nil {
            birthDisplay.text = UserInformation.shared.birth
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIApplication.shared.windows.first?
            .windowScene?.interfaceOrientation.isLandscape == true {
            if datePickerHeight != nil {
                datePickerHeight.isActive = false
                datePickerHeight = self.birthPicker.heightAnchor.constraint(equalTo: self.birthPicker.widthAnchor, multiplier: 1)
                datePickerHeight.isActive = true
            }
        }
        
        if UIApplication.shared.windows.first?
            .windowScene?.interfaceOrientation.isPortrait == true {
            if datePickerHeight != nil {
                datePickerHeight.isActive = false
                datePickerHeight = self.birthPicker.heightAnchor.constraint(equalTo: self.birthPicker.widthAnchor, multiplier: 0.3)
                datePickerHeight.isActive = true
            }
        }
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? SignInViewController {
            if (UserInformation.shared.id != nil) && (UserInformation.shared.pw != nil) {
                destination.idField.text = UserInformation.shared.id
                destination.pwField.text = UserInformation.shared.pw
            }
        }
    }
    
}




// MARK: ThirdViewController Methods
extension ThirdViewController {
    
    @objc func didDatePickerValueChanged(_ sender: UIDatePicker) {
        
        let date: Date = self.birthPicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.birthDisplay.text = dateString
        
        if (self.phoneField.hasText) && (self.birthDisplay.text != "MMMM-dd-yyyy") {
            doneButton.setTitleColor(.systemBlue, for: .normal)
            doneButton.isUserInteractionEnabled = true
        }
    }
    
    
    @objc func touchUpCancelButton(_ sender: UIButton) {
        
        UserInformation.shared.id = nil
        UserInformation.shared.pw = nil
        UserInformation.shared.text = nil
        UserInformation.shared.phone = nil
        UserInformation.shared.birth = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func touchUpPrevButton(_ sender: UIButton) {
        
        UserInformation.shared.phone = phoneField.text
        UserInformation.shared.birth = birthDisplay.text
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func touchUpDoneButton(_ sender: UIButton) {
        
        // phoneField, birthDisplay 모두 빈문자열 아니고, nil 도 아닐 때
        guard let phoneInput = phoneField.text, !phoneInput.isEmpty else { return }
        guard let birthSelected = birthDisplay.text, !birthSelected.isEmpty else { return }
        
        if (!phoneInput.isEmpty) && (birthSelected != "MMMM-dd-yyyy") {
            
            UserInformation.shared.phone = phoneInput
            UserInformation.shared.birth = birthSelected
            
            // print("가입 완료")
            // print("\(UserInformation.shared.description)")
            
            performSegue(withIdentifier: "unwindToMain", sender: self)
        }
    }
    
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if (self.phoneField.hasText) && (self.birthDisplay.text != "MMMM-dd-yyyy") {
            doneButton.setTitleColor(.systemBlue, for: .normal)
            doneButton.isUserInteractionEnabled = true
        }
        // print("check if textField changed")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}




// MARK: ThirdViewController Views
extension ThirdViewController {
    
    func addViews() {
        self.addUIView()
        self.addPhoneLabel()
        self.addPhoneField()
        self.addBirthLabel()
        self.addBirthDisplay()
        self.addBirthPicker()
        self.addCancelButton()
        self.addPrevButton()
        self.addDoneButton()
    }
    
    
    func addUIView() {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        
        view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        
        self.uiView = view
    }
    
    
    func addPhoneLabel() {
        let phone: UILabel = UILabel()
        phone.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(phone)
        
        phone.text = "전화번호"
        phone.textColor = UIColor.black
        phone.textAlignment = NSTextAlignment.left
        phone.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        phone.topAnchor.constraint(equalTo: self.uiView.topAnchor).isActive = true
        phone.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor).isActive = true
        phone.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.3).isActive = true
        
        self.phoneLabel = phone
    }
    
    
    func addPhoneField() {
        let phoneField: UITextField = UITextField()
        phoneField.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(phoneField)
        
        phoneField.borderStyle = UITextField.BorderStyle.roundedRect
        phoneField.keyboardType = .numberPad
        phoneField.placeholder = "Number"
        
        phoneField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        phoneField.topAnchor.constraint(equalTo: self.phoneLabel.bottomAnchor, constant: 8).isActive = true
        phoneField.leadingAnchor.constraint(equalTo: self.phoneLabel.leadingAnchor).isActive = true
        phoneField.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor).isActive = true
        
        self.phoneField = phoneField
    }
    
    
    func addBirthLabel() {
        let birth: UILabel = UILabel()
        birth.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(birth)
        
        birth.text = "생년월일"
        birth.textColor = UIColor.black
        birth.textAlignment = NSTextAlignment.left
        birth.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        birth.topAnchor.constraint(equalTo: self.phoneField.bottomAnchor, constant: 8).isActive = true
        birth.leadingAnchor.constraint(equalTo: self.phoneLabel.leadingAnchor).isActive = true
        birth.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.3).isActive = true
        
        self.birthLabel = birth
    }
    
    
    func addBirthDisplay() {
        let birthDisplay: UILabel = UILabel()
        birthDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(birthDisplay)
        
        birthDisplay.text = "MMMM-dd-yyyy"
        birthDisplay.textColor = UIColor.black
        birthDisplay.textAlignment = NSTextAlignment.center
        birthDisplay.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        birthDisplay.topAnchor.constraint(equalTo: self.phoneField.bottomAnchor, constant: 8).isActive = true
        birthDisplay.leadingAnchor.constraint(equalTo: self.uiView.centerXAnchor).isActive = true
        birthDisplay.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.4).isActive = true
        
        self.birthDisplay = birthDisplay
    }
    
    
    func addBirthPicker() {
        let birthPick: UIDatePicker = UIDatePicker()
        birthPick.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(birthPick)
        
        // datePicker 날짜까지만 나오게 세팅
        birthPick.datePickerMode = UIDatePicker.Mode.date
        
        if #available(iOS 14, *) {
            birthPick.preferredDatePickerStyle = .wheels
        }
        
        birthPick.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        birthPick.topAnchor.constraint(equalTo: self.birthLabel.bottomAnchor, constant: 8).isActive = true
        birthPick.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor).isActive = true
        birthPick.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor).isActive = true
        datePickerHeight = birthPick.heightAnchor.constraint(equalTo: birthPick.widthAnchor, multiplier: 1)
        datePickerHeight.isActive = true
        // birthPick.heightAnchor.constraint(equalTo: birthPick.widthAnchor, multiplier: 1).isActive = true
        
        self.birthPicker = birthPick
    }
    
    
    func addCancelButton() {
        let cancel: UIButton = UIButton(type: UIButton.ButtonType.custom)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(cancel)
        
        cancel.setTitle("취소", for: UIControl.State.normal)
        cancel.setTitleColor(.systemRed, for: .normal)
        cancel.backgroundColor = .none
        
        cancel.addTarget(self, action: #selector(self.touchUpCancelButton(_:)), for: UIControl.Event.touchUpInside)
        
        cancel.topAnchor.constraint(equalTo: self.birthPicker.bottomAnchor, constant: 16).isActive = true
        cancel.leadingAnchor.constraint(equalTo: self.uiView.leadingAnchor, constant: 32).isActive = true
        cancel.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.3).isActive = true
        
        self.cancelButton = cancel
    }
    
    
    func addPrevButton() {
        let prev: UIButton = UIButton(type: UIButton.ButtonType.custom)
        prev.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(prev)
        
        prev.setTitle("이전", for: UIControl.State.normal)
        prev.setTitleColor(.systemBlue, for: .normal)
        prev.backgroundColor = .none
        
        prev.addTarget(self, action: #selector(self.touchUpPrevButton(_:)), for: UIControl.Event.touchUpInside)
        
        prev.topAnchor.constraint(equalTo: self.birthPicker.bottomAnchor, constant: 16).isActive = true
        prev.centerXAnchor.constraint(equalTo: self.uiView.centerXAnchor).isActive = true
        prev.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.3).isActive = true
        
        self.prevButton = prev
    }
    
    
    func addDoneButton() {
        let done: UIButton = UIButton(type: UIButton.ButtonType.custom)
        done.translatesAutoresizingMaskIntoConstraints = false
        
        self.uiView.addSubview(done)
        
        done.setTitle("완료", for: UIControl.State.normal)
        done.setTitleColor(.systemGray, for: .normal)
        done.backgroundColor = .none
        done.isUserInteractionEnabled = false
        
        done.addTarget(self, action: #selector(self.touchUpDoneButton(_:)), for: UIControl.Event.touchUpInside)
        
        done.topAnchor.constraint(equalTo: self.birthPicker.bottomAnchor, constant: 16).isActive = true
        done.trailingAnchor.constraint(equalTo: self.uiView.trailingAnchor, constant: -32).isActive = true
        done.widthAnchor.constraint(equalTo: self.uiView.widthAnchor, multiplier: 0.3).isActive = true
        
        self.doneButton = done
    }
}
