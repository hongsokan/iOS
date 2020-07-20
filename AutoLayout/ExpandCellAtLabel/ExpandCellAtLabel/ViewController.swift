//
//  ViewController.swift
//  ExpandCellAtLabel
//
//  Created by 안홍석 on 2020/07/20.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ExpandCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 구조
    // 필요한 텍스트 포함
    // expand 상태
    
    // Model
    struct ExpandDataModel {
        var description: String
        var isExpand: Bool
    }
    
    var dataModels = [ExpandDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textArray = ["short text", "long long long long long long long long long long long long long long long long long long text", "short text",  "long long long long long long long long long long long long long long long long long long text",  "short text", "long long long long long long long long long long long long long long long long long long text"]
        
        for (_ , value) in textArray.enumerated() {
            
            dataModels.append(ExpandDataModel.init(description: value, isExpand: false))
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandCell_ID", for: indexPath) as! ExpandCell
        
        cell.descriptionLabel.text = dataModels[indexPath.row].description
        
        // 확장하지 않으면 description Label은 기본값이 1줄
        // 여기선 Label 길이만큼 cell 높이 확장해야 된다
        if dataModels[indexPath.row].isExpand == true {
            cell.descriptionLabel.numberOfLines = 0
        }
        else {
            cell.descriptionLabel.numberOfLines = 1
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataModels[indexPath.row].isExpand = !dataModels[indexPath.row].isExpand
        
        // Autolayout Performance 문제 해결
        // 1. heightForRowAt 에서 정확한 높이 지정
        // 2. tableView.reloadData() // 어느 정도 해결
        // 3. 어느 정도 해결
        // tableView.estimatedSectionHeaderHeight = 0
        // tableView.estimatedSectionFooterHeight = 0
        // 4. 애니메이션 효과 없게, 확실히 해결
        UIView.setAnimationsEnabled(false)
        // 선택한 row의 데이터만 갱신
        tableView.reloadRows(at: [indexPath], with: .automatic)
        UIView.setAnimationsEnabled(true)

    }
    
    
}

