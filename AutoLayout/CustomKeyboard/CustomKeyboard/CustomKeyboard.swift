//
//  CustomKeyboard.swift
//  CustomKeyboard
//
//  Created by 안홍석 on 2020/07/17.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

protocol CustomKeyboardDelegate {
    func keyboardTapped(str: String)
}

class CustomKeyboard: UIView {
    
    var delegate: CustomKeyboardDelegate?

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        // 입력 받은 숫자를 ViewController로 전달
        // delegate 패턴
        
        delegate?.keyboardTapped(str: sender.titleLabel!.text!)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
