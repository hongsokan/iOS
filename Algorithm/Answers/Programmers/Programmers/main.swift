//
//  main.swift
//  Programmers
//
//  Created by 안홍석 on 2020/09/12.
//  Copyright © 2020 안홍석. All rights reserved.
//


// 2019 KAKAO BLIND RECRUITMENT
// 2019 KAKAO BLIND RECRUITMENT
// 2019 KAKAO BLIND RECRUITMENT
// 2019 KAKAO BLIND RECRUITMENT
// 2019 KAKAO BLIND RECRUITMENT




// 2019 KAKAO BLIND RECRUITMENT 02 실패율
// 전체 스테이지 개수 n
// 게임을 이용하는 사용자가 현재 멈춰있는 스테이지의 번호가 담긴 배열 stages
// 실패율 = 스테이지에 도달했으나 아직 클리어하지 못한 플레이어의 수 / 스테이지에 도달한 플레이어 수
// 테스트케이스1 n=5, stages=[2, 1, 2, 6, 2, 4, 3, 3], result=[3,4,2,1,5]

import Foundation

let n = 5
let stages = [2, 1, 2, 6, 2, 4, 3, 3]
// let result = [3,4,2,1,5]

//let n = 4
//let stages = [4,4,4,4,4]

var rates: [Double] = .init(repeating: 0, count: n)
var userStages: [Int: Int] = [:]

stages.forEach {
    print($0)
}

stages.forEach {
    if let value = userStages[$0] {
        userStages[$0] = value + 1
    }
    else {
        userStages[$0] = 1
    }
}

var user = stages.count

userStages.keys.sorted().forEach {
    guard let value = userStages[$0], $0 <= n else { return }
    rates[$0-1] = Double(value) / Double(user)
    user -= value
    
//    print("value is : " + "\(value)")
//    print(rates[$0-1])
//    print(user)
}

print( rates.enumerated()
.sorted { $0.element > $1.element } // rates의 element(실패율) 높은 순으로 정렬
.map { $0.offset + 1 } ) // offset 0~4 이므로 +1





/*
// 2019 KAKAO BLIND RECRUITMENT 01 오픈채팅방
// Enter, Leave, Change 중 하나
// record: ["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]
// result: ["Prodo님이 들어왔습니다.", "Ryan님이 들어왔습니다.", "Prodo님이 나갔습니다.", "Prodo님이 들어왔습니다."]

import Foundation

func solution(_ record:[String]) -> [String] {
    
    var answer = [String]()
    var userList = [String: String]()
    
        // i[0]: Enter, Change, Leave
        // i[1]: uid
        // i[2]: 닉네임
    for i in record { // Enter와 Change 인 경우 닉네임 정보 user_list에 저장
        if i.components(separatedBy: " ")[0] == "Enter" || i.components(separatedBy: " ")[0] == "Change" {
            userList[i.components(separatedBy: " ")[1]] = i.components(separatedBy: " ")[2]
        }
    }
    
    for i in record { // Enter와 Leave 인 경우 특정 ID의 닉네임 answer에 추가
        if i.components(separatedBy: " ")[0] == "Enter" {
            answer.append(String(userList[i.components(separatedBy: " ")[1]] ?? "") + "님이 들어왔습니다.")
        }
        else if i.components(separatedBy: " ")[0] == "Leave" {
            answer.append(String(userList[i.components(separatedBy: " ")[1]] ?? "") + "님이 나갔습니다.")
        }
    }
    
    return answer
}
*/

