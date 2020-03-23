//
//  ViewController.swift
//  SimpleTable
//
//  Created by 안홍석 on 2020/02/05.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    let customCellIdentifier: String = "customCell"
    
    let korean: [String] = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"]
    let english: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    var dates: [Date] = []
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        dates.append(Date())
        
//        self.tableView.reloadData()
        
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 테이블뷰 델리게이트와 데이터 소스 코드로 연결하려면
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    
    // 테이블뷰에 몇 개의 섹션이 있는지
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // UITableViewDataSource 프로토콜 준수 위해 필수 구현 메서드들
    
    // 섹션에 해당하는 로우가 몇 개여야 하는지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    // 로우마다 해당하는 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 2 {
            
            
            // dequeueReusableCell, 셀의 재사용
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            
            cell.textLabel?.text = text
            
            return cell
        }
        
        else {
            
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as! CustomTableViewCell
            
//            cell.textLabel?.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            
            cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            
            cell.rightLabel.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2 {
            return section == 0 ? "한글" : "영어"

        }
        
        return nil
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // segue.destination 으로 새로운 뷰 컨트롤러 가져올 수 있다
        // 선택된 객체를 새로운 뷰 컨트롤러에 전달
        
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        nextViewController.textToSet = cell.textLabel?.text
    }


}

