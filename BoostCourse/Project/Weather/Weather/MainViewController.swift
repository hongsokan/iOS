//
//  ViewController.swift
//  Weather
//
//  Created by 안홍석 on 2020/02/12.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let customCellIdentifier: String = "customCell"
    var countries: [Country] = []
    var initial: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.topItem?.title = "세계 날씨"
        self.navigationController?.navigationBar.backgroundColor = .systemBlue
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries")
            else {  return  }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
        
    }
}




// MARK: TableView Delegate
extension MainViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // tableview 구현 시 필수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return country.count
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell, 셀의 재사용
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as! CustomTableViewCell
        
        let country: Country = self.countries[indexPath.row]
        
        cell.leftLabel?.text = country.koreanName
        cell.leftImage?.image = UIImage(named: country.asset)
        
        cell.assetInitial = country.assetName
        
        return cell
    }
}




// MARK: - Navigation
extension MainViewController {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // segue.destination 으로 새로운 뷰 컨트롤러 가져올 수 있다
        // 선택된 객체를 새로운 뷰 컨트롤러에 전달
        
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell: CustomTableViewCell = sender as? CustomTableViewCell else {
            return
        }
        
        nextViewController.countryKorean = cell.leftLabel?.text
        nextViewController.countryInitial = cell.assetInitial
    }
}
