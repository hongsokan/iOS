//
//  FacebookViewController.swift
//  FirebaseLogin
//
//  Created by 안홍석 on 2020/08/13.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase

class FacebookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
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
