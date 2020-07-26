//
//  ViewController.swift
//  Switch_Custom
//
//  Created by 안홍석 on 2020/07/26.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var switchBG: UIView!
    @IBOutlet weak var buttonCenterX: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buttonCenterX.constant = -75
        switchButton.layer.cornerRadius = switchButton.bounds.height / 2
        switchBG.layer.cornerRadius = switchBG.bounds.height / 2
    }

    @IBAction func selectedBtn(_ sender: Any) {
        if buttonCenterX.constant == 75 {
            buttonCenterX.constant = -75
            switchBG.backgroundColor = .lightGray
        } else {
            buttonCenterX.constant = 75
            switchBG.backgroundColor = .systemBlue
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}

