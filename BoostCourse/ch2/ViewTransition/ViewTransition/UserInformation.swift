//
//  UserInformation.swift
//  ViewTransition
//
//  Created by 안홍석 on 2020/01/29.
//  Copyright © 2020 안홍석. All rights reserved.
//


// Singleton 구현

import Foundation

class UserInformation {
    // shared 라는 이름의 타입 프로퍼티
    // 싱글턴 패턴을 사용할 때 shared 처럼 자주 사용되는 이름은 피하는 것이 좋다
    // 해킹 공격에 취약할 수도 있다
    static let shared: UserInformation = UserInformation()
    
    var name: String?
    var age: String?
}
