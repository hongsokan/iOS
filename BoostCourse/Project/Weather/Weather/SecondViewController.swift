//
//  SecondViewController.swift
//  Weather
//
//  Created by 안홍석 on 2020/02/13.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    var countryKorean: String?
    var countryInitial: String?
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "cityCell"
    
    var cities: [City] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "\(countryInitial!)")
            else {  return  }
        
        do {
            self.cities = try jsonDecoder.decode([City].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.countryKorean
        print("\(countryKorean!)")
        print("\(countryInitial!)")
        //        print("\(countryInitial!)")
    }
    
    
    
    // MARK: - TABLE
    
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
        
        // state == 10 sunny
        // state == 11 cloudy
        // state == 12 rainy
        // state == 13 snowy
        
        cell.leftImage?.image = UIImage(named: "\(stateToWeather)")
        cell.cityName?.text = city.cityName
        cell.cityName?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell.cityTemperature?.text = "섭씨" + String(city.celsius) + "도 / 화씨 " + String(format: "%.1f", city.fahrenheit) + "도"
        cell.cityTemperature?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        cell.cityRain?.text = "강수확률 " + String(city.rainfall) + "%"
        cell.cityRain?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        
        return cell
    }
    
    
    
    
    // MARK: - Navigation
    
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
