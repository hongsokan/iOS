//
//  ViewController.swift
//  SignInTest
//
//  Created by 안홍석 on 2020/08/05.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    var emailErrorHeight: NSLayoutConstraint!
    var passwordErrorHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // textfield 값이 변경되는 것을 캐치하는게 기본적으로 없음, 직접 세팅
        
        emailTextField.addTarget(self, action: #selector(textFieldEdited), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEdited(textField:)), for: .editingChanged)
        emailErrorHeight = emailErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        passwordErrorHeight = passwordErrorLabel.heightAnchor.constraint(equalToConstant: 0)
    }
    
    @objc func textFieldEdited(textField: UITextField) {
        
        if textField == emailTextField {
            print("email text field \(textField.text!)")
            
            if isValidEmail(email: textField.text) == true {
                // 에러 표시 나오지 않아야 함
                emailErrorHeight.isActive = true
            } else {
                emailErrorHeight.isActive = false
            }
            
        } else if textField == passwordTextField {
            print("password text field \(textField.text!)")
            if isValidPassword(pw: textField.text) == true {
                passwordErrorHeight.isActive = true
            } else {
                passwordErrorHeight.isActive = false
            }
            
        }
        
        // 애니메이션 효과
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    // 정규식 - regular expression
    
    func isValidEmail(email : String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email) // return true, false
    }
    
    func isValidPassword(pw: String?) -> Bool {
        
        if let hasPassword = pw {
            if hasPassword.count < 8 {
                return false
            }
        }
        
        return true
    }


}

