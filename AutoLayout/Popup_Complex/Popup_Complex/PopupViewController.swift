//
//  PopupViewController.swift
//  Popup_Complex
//
//  Created by 안홍석 on 2020/08/03.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func doneAction(_ sender: Any) {
        print("press done action")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
