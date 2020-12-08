//
//  SecondViewController.swift
//  Weather
//
//  Created by 안홍석 on 2020/02/13.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "cityCell"
    
    var countryKorean: String?
    var countryInitial: String?
    var cities: [City] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        jsonDecode()
        self.tableView.reloadData()
        
        self.navigationItem.title = self.countryKorean
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
}




// MARK: Method
extension SecondViewController {
    
    func jsonDecode() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "\(countryInitial!)")
            else {  return  }
        
        do {
            self.cities = try jsonDecoder.decode([City].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
            
            let message: String
            message = "City 데이터를 가져올 수 없습니다"
            
            let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
                
                self.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}




// MARK: TableView Delegate
extension SecondViewController:
    UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell, 셀의 재사용
        let cell: SecondCustomCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! SecondCustomCell
        
        let city: City = self.cities[indexPath.row]
        
        var stateToWeather: String = ""
        switch city.state {
        case 10:
            stateToWeather = "sunny"
        case 11:
            stateToWeather = "cloudy"
        case 12:
            stateToWeather = "rainy"
        case 13:
            stateToWeather = "snowy"
        default:
            print("error")
        }
        
        cell.stateForCity = city.state
        
        cell.leftImage?.image = UIImage(named: "\(stateToWeather)")
        cell.cityName?.text = city.cityName
        cell.cityName?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell.cityTemperature?.text = "섭씨" + String(city.celsius) + "도 / 화씨 " + String(format: "%.1f", city.fahrenheit) + "도"
        cell.cityTemperature?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        cell.cityRain?.text = "강수확률 " + String(city.rainfall) + "%"
        cell.cityRain?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        if city.rainfall > 50 {
            cell.cityRain.textColor = .systemOrange
        }
        
        return cell
    }
}




// MARK: - Navigation
extension SecondViewController: UINavigationControllerDelegate {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
         guard let nextViewController: ThirdViewController = segue.destination as? ThirdViewController else {
         return
         }
         
         guard let cell: SecondCustomCell = sender as? SecondCustomCell else {
         return
         }
         
        nextViewController.cityName = cell.cityName?.text
        nextViewController.stateImage = cell.leftImage?.image
        nextViewController.cityState = cell.stateForCity
        nextViewController.cityTemp = cell.cityTemperature?.text
        nextViewController.cityRain = cell.cityRain?.text
    }
}
