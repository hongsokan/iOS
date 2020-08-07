//
//  ViewController.swift
//  Chat_App
//
//  Created by 안홍석 on 2020/08/06.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var chatTableView: UITableView! {
        didSet {
            chatTableView.delegate = self
            chatTableView.dataSource = self
            chatTableView.separatorStyle = .none
        }
    }
    
    var chatDatas = [String]()
    
    @IBOutlet weak var inputTextView: UITextView! {
        didSet {
            inputTextView.delegate = self
        }
    }
    
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var inputTextViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 사용하려는 셀을 등록해야 사용 가능
        chatTableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        chatTableView.register(UINib(nibName: "YourCell", bundle: nil), forCellReuseIdentifier: "yourCell")
        
        // 키보드 관련 옵저버 설정을 해야 함 - 상태 알려주는 것
        // 키보드 올라올 때
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 내려올 때
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        // inputViewBottomMargin.constant = keyboardHeight
        
        // 애니메이션 효과로 자연스럽게
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval

        // inputViewBottomMargin.constant = 0
        
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 여기선 일단 같은 배열에서 순서대로 myCell, yourCell 구분
        if indexPath.row % 2 == 0 {
            
            let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCell
            myCell.myTextView.text = chatDatas[indexPath.row]
            myCell.selectionStyle = .none
            
            return myCell
            
        } else {
            
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "yourCell", for: indexPath) as! YourCell
            yourCell.yourTextView.text = chatDatas[indexPath.row]
            yourCell.selectionStyle = .none
            
            return yourCell
        }
        
    }
    

    @IBAction func sendString(_ sender: Any) {
        chatDatas.append(inputTextView.text)
        inputTextView.text = ""
        
        // 3개 데이터가 있는 array일 경우
        // array.count = 3
        // array row => 2
        let lastIndexPath = IndexPath(row: chatDatas.count - 1, section: 0)
        
        // chatTableView.reloadData()
        chatTableView.insertRows(at: [lastIndexPath], with: UITableView.RowAnimation.automatic)

        chatTableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.contentSize.height <= 40 {
            inputTextViewHeight.constant = 40
        }
        else if textView.contentSize.height >= 100 {
            inputTextViewHeight.constant = 100
        }
        else {
            inputTextViewHeight.constant = textView.contentSize.height
        }
    }
}

