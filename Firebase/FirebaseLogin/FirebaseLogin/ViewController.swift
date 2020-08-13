//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by 안홍석 on 2020/08/13.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        
        let googleStoryboard = UIStoryboard(name: "GoogleStoryboard", bundle: nil)
        
        let googleVC = googleStoryboard.instantiateViewController(withIdentifier: "googleVC")
        
        self.present(googleVC, animated: true, completion: nil)
    }
    
    @IBAction func emailLogin(_ sender: Any) {
        
        let emailStoryboard = UIStoryboard(name: "EmailStoryboard", bundle: nil)
        
        let emailVC = emailStoryboard.instantiateViewController(withIdentifier: "emailVC")
        
        self.present(emailVC, animated: true, completion: nil)
        
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        
        let facebookVC = FacebookViewController()
        
        self.present(facebookVC, animated: true, completion: nil)
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
