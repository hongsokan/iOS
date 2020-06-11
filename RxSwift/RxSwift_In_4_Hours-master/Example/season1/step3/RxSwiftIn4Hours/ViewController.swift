//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    // MARK: - IBOutler

    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var idValidView: UIView!
    @IBOutlet var pwValidView: UIView!

    // MARK: - Bind UI

    private func bindUI() {
        // id input +--> check valid --> bullet
        //          |
        //          +--> button enable
        //          |
        // pw input +--> check valid --> bullet
        
        
        idField.rx.text
            .filter { $0 != nil }
            .map { $0! }    // orEmpty로 대체 가능
            .map(checkEmailValid)
            .subscribe(onNext: { b in
                self.idValidView.isHidden = b
                // print(s)
            })
            .disposed(by: disposeBag)
        
        pwField.rx.text.orEmpty
        .map(checkPasswordValid)
        .subscribe(onNext: { b in
            self.pwValidView.isHidden = b
        })
        .disposed(by: disposeBag)
        
        
        // 두 가지 유효성 검사 과정 combine
        // ComebineLatest : 두 개의 Observable 배출한 각 항목 결합, 함수 적용하여 실행, 결과 배출
        Observable.combineLatest(
            idField.rx.text.orEmpty.map(checkEmailValid),
            pwField.rx.text.orEmpty.map(checkPasswordValid),
            resultSelector: { s1, s2 in s1 && s2 }
        )
            .subscribe(onNext: { b in
                self.loginButton.isEnabled = b
            })
            .disposed(by: disposeBag)
        
        
        
        // 리팩토링
        
        // input : id 입력, pw 입력
        // 이런 식으로 스트림을 나눠서 구현 가능
        let idInputOb : Observable<String> = idField.rx.text.orEmpty.asObservable()
        let idValidOb = idInputOb.map(checkEmailValid)

        let pwInputOb : Observable<String> = pwField.rx.text.orEmpty.asObservable()
        let pwValidOb = pwInputOb.map(checkPasswordValid)
        
        // output : bullet, loginButton enable
        
        idValidOb.subscribe(onNext: { b in self.idValidView.isHidden = b })
            .disposed(by: disposeBag)
        
        pwValidOb.subscribe(onNext: { b in self.pwValidView.isHidden = b })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(idValidOb, pwValidOb, resultSelector: { $0 && $1 })
            .subscribe(onNext: { b in self.loginButton.isEnabled = b })
            .disposed(by: disposeBag)
        
        
        
        /*
        
        // Subject : 옵저버나 Observable 처럼 행동하는 일종의 교각 혹은 프록시
        // AsyncSubject, BehaviorSubject, PublishSubject, ReplaySubject
        
        // value 는 default 값 (idValid 와 pwValid 는 함수 외부 변수, 여기선 이해를 위해 이쪽에 선언)
        let idValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
        let pwValid : BehaviorSubject<Bool> = BehaviorSubject(value: false)
        
        let idInputOb : Observable<String> = idField.rx.text.orEmpty.asObservable()
        let idValidOb = idInputOb.map(checkEmailValid)
        idValidOb.bind(to: idValid) // idValidOb 에서 무언가 발생하면, idValid 로 전달
            .disposed(by: disposeBag)
        
        let pwInputOb : Observable<String> = pwField.rx.text.orEmpty.asObservable()
        let pwValidOb = pwInputOb.map(checkPasswordValid)
        pwValidOb.bind(to: pwValid)
            .disposed(by: disposeBag)

        
        // bind() 로 입력된 텍스트 외부로 저장
        let idInputText: BehaviorSubject<String> = BehaviorSubject(value: "")
        let pwInputText: BehaviorSubject<String> = BehaviorSubject(value: "")

        
        // bindInput(), bindOutput() 나눠서 처리 가능
        
        */
 
    }

    // MARK: - Logic

    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    private func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 5
    }
}
