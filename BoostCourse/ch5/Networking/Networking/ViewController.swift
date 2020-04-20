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
        cell.imageView?.image = nil
        
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
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
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
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

