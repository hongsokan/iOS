//
//  RxSwiftViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxSwift
import UIKit

class RxSwiftViewController: UIViewController {
    // MARK: - Field

    var counter: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }

    // MARK: - IBOutlet

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var countLabel: UILabel!

    // MARK: - IBAction
    
    
    var disposable: Disposable?
    var disposeBag: DisposeBag = DisposeBag()
    
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil

//        disposable = rxswiftLoadImage(from: LARGER_IMAGE_URL)
        
            rxswiftLoadImage(from: LARGER_IMAGE_URL)
            .observeOn(MainScheduler.instance)
            .subscribe({ result in
                switch result {
                case let .next(image):
                    self.imageView.image = image

                case let .error(err):
                    print(err.localizedDescription)

                case .completed:
                    break
                }
                }).disposed(by: disposeBag)
//        DisposeBag.insert(disposable)
    }

    // disposable 변수로 이미지 받아오는 작업을 받아와서 dispose 해주면 쉽게 진행 중인 비동기 작업 취소 가능
    // disposeBag 처럼 사용도 가능
    @IBAction func onCancel(_ sender: Any) {
        // TODO: cancel image loading
        
//        disposable?.dispose()
        disposeBag = DisposeBag()
    }

    // MARK: - RxSwift

    func rxswiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
        return Observable.create { seal in
            asyncLoadImage(from: imageUrl) { image in
                seal.onNext(image)
                seal.onCompleted()
            }
            return Disposables.create()
        }
    }
}
