//
//  Request.swift
//  Networking
//
//  Created by 안홍석 on 2020/04/19.
//  Copyright © 2020 안홍석. All rights reserved.
//

import Foundation

let DidReceiveFriendsNotification: Notification.Name = Notification.Name("DidReceiveFriends")

func requestFriends() {
    
    guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    
    // dataTask는 url로 요청, 서버로부터 응답이 오면 클로저 실행, 클로저는 백그라운드에서 실행
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        // 어떤 오류인지 확인
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        
        // 서버로부터 온 데이터 decode 하고, 그 결과 friends로, 그리고 reload
        // 백그라운드에서 실행되고 있기 때문에 tableView.reloadData()는 메인스레드 처리 필요
        do {
            let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            
            // Notification 처리
            /*
            self.friends = apiResponse.results
            
            // DispatchQueue로 백그라운드에서 메인스레드 처리
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }   */
            
            NotificationCenter.default.post(name: DidReceiveFriendsNotification, object: nil, userInfo: ["friends": apiResponse.results])
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    
    dataTask.resume()
}

