//
//  ViewController.swift
//  Popup_Complex
//
//  Created by 안홍석 on 2020/08/03.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func showPopup(_ sender: Any) {
        // PopupViewController
        
        let storyBoard = UIStoryboard.init(name: "PopupViewController", bundle: nil)
        
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "popupVC")
        
        popupVC.modalPresentationStyle = .overCurrentContext
        
        self.present(popupVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

