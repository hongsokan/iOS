//
//  UserInfo.swift
//  SignUp
//
//  Created by 안홍석 on 2020/01/30.
//  Copyright © 2020 안홍석. All rights reserved.
//

import Foundation

class UserInformation {
    
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var pw: String?
    
    
    /*
    struct User {
        var userid: String
        var userpw: String
    }
    
    // 모델 및 더미 데이터 추가
    var model: [User] = [
        User(userid: "A", userpw: "1"),
        User(userid: "Aaa", userpw: "111")
    ]
    
    // 해당 유저 있는지 검사
    func isUser(id: String, pw: String) -> Bool {
        for user in model {
            if (user.userid == id && user.userpw == pw) {
                return true
            }
        }
        return false
    }
    
    // user 추가 메서드
    func addUser(id: String, pw: String) {
        let newUser = User(userid: id, userpw: pw)
        model.append(newUser)
    }
    */
}
