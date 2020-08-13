//
//  EmailViewController.swift
//  FirebaseLogin
//
//  Created by 안홍석 on 2020/08/13.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase

class EmailViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        
    }

    @IBAction func signInButton(_ sender: Any) {
        
        // 사용자 이메일 인증
        Auth.auth().createUser(withEmail: emailTextfield.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
            
            if (error != nil) { return }
            
            let alert = UIAlertController(title: "알림", message: "회원가입 완료", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
          // ...
        }
        
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
