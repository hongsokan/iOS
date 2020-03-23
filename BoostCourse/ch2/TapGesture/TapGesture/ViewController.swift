//
//  ViewController.swift
//  TapGesture
//
//  Created by 안홍석 on 2020/01/30.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // 인터페이스를 통해 탭제스처 구현
//    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 델리게이트로 탭제스처 구현
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        // 이런 식으로 인터페이스 + 코드로 탭제스처 구현 가능, 또 다른 방법은 델리게이트 활용
//        let tapGesture: UITapGestureRecognizer =
//            UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
//
//        self.view.addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }


}

