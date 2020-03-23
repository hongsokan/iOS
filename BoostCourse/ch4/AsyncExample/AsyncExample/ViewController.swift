//
//  ViewController.swift
//  AsyncExample
//
//  Created by 안홍석 on 2020/02/21.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        // 이미지 다운로드 -> 이미지뷰에 세팅
        // https://lh3.googleusercontent.com/proxy/mV7AXuPXcw7YAa6Atg-gyHnWA3ZjUSv6q6b5Xu-3GyMR-J0BjSRTPwgEqy6fLuZqpC6JN5JmE1xJbGn5r455
        // http 같은 경우는 info.plist 에서 App Transport Security Setting 추가하여 Add row 로 Allow Arbitary Loads = YES
        
        let imageURL: URL = URL(string: "https://lh3.googleusercontent.com/proxy/mV7AXuPXcw7YAa6Atg-gyHnWA3ZjUSv6q6b5Xu-3GyMR-J0BjSRTPwgEqy6fLuZqpC6JN5JmE1xJbGn5r455")!
        // 동기성 프로그래밍, 해당 코드가 실행될 때까지 다음으로 넘어가지 않게 된다.
//        let imageData: Data = try! Data.init(contentsOf: imageURL)
//        let image: UIImage = UIImage(data: imageData)!
        
        OperationQueue().addOperation {
            let imageData: Data = try! Data.init(contentsOf: imageURL)
            let image: UIImage = UIImage(data: imageData)!
            
            // UI 에 영향을 주는 코드는 메인 스레드에서 진행되어야 한다.
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
            // 이런 식으로 큰 용량의 이미지를 불러오는 등 큰 작업은 백그라운드에 맡겨두고 메인스레드에선 주요 작업을 계속 처리하는 비동기 프로그래밍 방식은 잘 알아둘 필요가 있다.
        }
        
//        self.imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

