//
//  ThirdViewController.swift
//  SignUp
//
//  Created by 안홍석 on 2020/02/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var birthDisplay: UILabel!
    @IBOutlet weak var birthPicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.dateStyle = .short
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViewsWithCode()
    }
    
}




// MARK: ThirdViewController Methods
extension ThirdViewController {
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        print()
        print("value changed")
        
        let date: Date = self.birthPicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.birthDisplay.text = dateString
    }
    
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        
        UserInformation.shared.id = nil
        UserInformation.shared.pw = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpPrevButton(_ sender: UIButton) {
        
        UserInformation.shared.id = nil
        UserInformation.shared.pw = nil
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func touchUpDoneButton(_ sender: UIButton) {
        
        // phoneField, birthDisplay 모두 빈문자열 아니고, nil 도 아닐 때
        guard let phoneInput = phoneField.text, !phoneInput.isEmpty else { return }
        guard let birthSelected = birthDisplay.text, !birthSelected.isEmpty else { return }
        
        if birthDisplay.text != "MM-dd-yyyy" {
            
            print()
            print("ThirdVC -> MainVC")
            print("가입 완료")
            
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}




// MARK: ThirdViewController Views
extension ThirdViewController {
    
    func addViewsWithCode() {
        self.addPhoneLabel()
        self.addPhoneField()
        self.addBirthLabel()
        self.addBirthDisplay()
        self.addBirthPicker()
        self.addCancelButton()
        self.addPrevButton()
        self.addDoneButton()
    }
    
    
    func addPhoneLabel() {
        let phone: UILabel = UILabel()
        phone.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(phone)
        
        phone.text = "전화번호"
        phone.textColor = UIColor.black
        phone.textAlignment = NSTextAlignment.center
        phone.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        phone.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        phone.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        phone.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        self.phoneLabel = phone
    }
    
    
    func addPhoneField() {
        let phoneField: UITextField = UITextField()
        phoneField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(phoneField)
        
        phoneField.borderStyle = UITextField.BorderStyle.roundedRect
        phoneField.keyboardType = .default
        phoneField.placeholder = "phone number"
        
        phoneField.topAnchor.constraint(equalTo: self.phoneLabel.bottomAnchor, constant: 8).isActive = true
        phoneField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24).isActive = true
        phoneField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true
        
        self.phoneField = phoneField
    }
    
    
    func addBirthLabel() {
        let birth: UILabel = UILabel()
        birth.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(birth)
        
        birth.text = "생년월일"
        birth.textColor = UIColor.black
        birth.textAlignment = NSTextAlignment.center
        birth.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        birth.topAnchor.constraint(equalTo: self.phoneField.bottomAnchor, constant: 32).isActive = true
        birth.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        birth.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        self.birthLabel = birth
    }
    
    
    func addBirthDisplay() {
        let birthDisplay: UILabel = UILabel()
        birthDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(birthDisplay)
        
        birthDisplay.text = "MM-dd-yyyy"
        birthDisplay.textColor = UIColor.black
        birthDisplay.textAlignment = NSTextAlignment.center
        birthDisplay.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        birthDisplay.topAnchor.constraint(equalTo: self.phoneField.bottomAnchor, constant: 32).isActive = true
        birthDisplay.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        birthDisplay.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        self.birthDisplay = birthDisplay
    }
    
    
    func addBirthPicker() {
        let birthPick: UIDatePicker = UIDatePicker()
        birthPick.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(birthPick)
        
        // datePicker 날짜까지만 나오게 세팅
        birthPick.datePickerMode = UIDatePicker.Mode.date
        
        birthPick.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        birthPick.topAnchor.constraint(equalTo: self.birthLabel.bottomAnchor, constant: 32).isActive = true
        birthPick.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        birthPick.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        birthPick.heightAnchor.constraint(equalTo: birthPick.widthAnchor, multiplier: 1).isActive = true
        
        self.birthPicker = birthPick
        
    }
    
    
    func addCancelButton() {
        let cancel: UIButton = UIButton(type: UIButton.ButtonType.custom)
        cancel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cancel)
        
        cancel.setTitle("Cancel", for: UIControl.State.normal)
        cancel.backgroundColor = .systemBlue
        
        cancel.addTarget(self, action: #selector(self.touchUpCancelButton(_:)), for: UIControl.Event.touchUpInside)
        
        cancel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        cancel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        cancel.topAnchor.constraint(equalTo: self.birthPicker.bottomAnchor, constant: 32).isActive = true
        
        self.cancelButton = cancel
    }
    
    
    func addPrevButton() {
        let prev: UIButton = UIButton(type: UIButton.ButtonType.custom)
        prev.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(prev)
        
        prev.setTitle("Prev", for: UIControl.State.normal)
        prev.backgroundColor = .systemBlue
        
        prev.addTarget(self, action: #selector(self.touchUpPrevButton(_:)), for: UIControl.Event.touchUpInside)
        
        prev.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        prev.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        prev.topAnchor.constraint(equalTo: self.birthPicker.bottomAnchor, constant: 32).isActive = true
        
        self.prevButton = prev
    }
    
    
    func addDoneButton() {
        let done: UIButton = UIButton(type: UIButton.ButtonType.custom)
        done.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(done)
        
        done.setTitle("Done", for: UIControl.State.normal)
        done.backgroundColor = .systemBlue
        
        done.addTarget(self, action: #selector(self.touchUpDoneButton(_:)), for: UIControl.Event.touchUpInside)
        
        done.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        done.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        done.topAnchor.constraint(equalTo: self.birthPicker.bottomAnchor, constant: 32).isActive = true
        
        self.doneButton = done
    }
}
