//
//  ViewController.swift
//  MyDatePicker
//
//  Created by 안홍석 on 2020/01/29.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        // 시간까지 레이블에 나타내고 싶다면
//        formatter.timeStyle = .medium
        // 직접 포맷을 정하고 싶다면
//        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        return formatter
    }()
    
    // 데이트피커에서 바뀐 값이 Date로 넘어온다
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        print("value changed")
        
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 뷰컨트롤러에 있는 메서드에 연결, 데이트피커 값이 바뀔 때 호출
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
    }


}

