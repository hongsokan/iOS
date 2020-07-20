//
//  FloatingButtonListViewController.swift
//  Floating_Button
//
//  Created by 안홍석 on 2020/07/20.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class FloatingButtonListViewController: UIViewController {

    @IBOutlet weak var btn3CenterY: NSLayoutConstraint!
    @IBOutlet weak var btn2CenterY: NSLayoutConstraint!
    @IBOutlet weak var btn1CenterY: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn1CenterY.constant = 0
        btn2CenterY.constant = 0
        btn3CenterY.constant = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        // 1초 간 constant 값이 이동
        UIView.animate(withDuration: 1) {
            self.btn1CenterY.constant = 80
            self.btn2CenterY.constant = 160
            self.btn3CenterY.constant = 240
            
            self.view.layoutIfNeeded()
        }   */
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.btn1CenterY.constant = 80
            self.btn2CenterY.constant = 160
            self.btn3CenterY.constant = 240
            
            self.view.layoutIfNeeded()
            
        }) { (completion) in
            // 애니메이션이 끝나는 시점
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
    
    @IBAction func dismissFloating(_ sender: Any) {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.btn1CenterY.constant = 0
            self.btn2CenterY.constant = 0
            self.btn3CenterY.constant = 0
            
            self.view.layoutIfNeeded()
            
        }) { (completion) in
            // 애니메이션이 끝나는 시점
            
            self.dismiss(animated: false, completion: nil)
        }
        
    }
    
    @IBAction func food3Action(_ sender: Any) {
        print("food3 selected")
    }
    
    
}
