//
//  ViewController.swift
//  Networking
//
//  Created by 안홍석 on 2020/04/19.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "friendCell"
    var friends: [Friend] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        
        // 이미지를 비워두는 것보다 플레이스홀더 용 이미지를 세팅하는 것이 좋다
        // cell.imageView?.image = nil
        cell.imageView?.image = UIImage(named: "default.png")
        
        /*
        // 비동기 처리하여 이미지 다운로드 필요
        guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return cell }
        guard let imageData: Data = try? Data(contentsOf: imageURL) else { return cell }
        cell.imageView?.image = UIImage(data: imageData)
        */
        
        // 이렇게 처리해도 이미지가 바로바로 들어오지 않을 수 있음
        // 플레이스홀더를 미리 설정하는 등 처리 필요
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                // cell 에서 세팅된 index와 다운로드 된 이미지의 index가 다를 수도 있다
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row { // index가 같도록 처리
                        cell.imageView?.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveFriendsNotification(_:)), name: DidReceiveFriendsNotification, object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestFriends()
    }
    
    @objc func didReceiveFriendsNotification(_ noti: Notification) {
        guard let friends: [Friend] = noti.userInfo?["friends"] as? [Friend] else { return }
        
        self.friends = friends
        
        // post하는 쪽에서 메인스레드 처리하였기 때문에 받는 쪽에서도 메인 스레드 처리 필요
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

