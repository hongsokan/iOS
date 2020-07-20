//
//  ViewController.swift
//  Floating_Button
//
//  Created by 안홍석 on 2020/07/20.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopup" {
            let floatingVC = segue.destination as! FloatingButtonListViewController
            floatingVC.modalPresentationStyle = .overCurrentContext
        }
    }

}

