//
//  ThirdViewController.swift
//  Weather
//
//  Created by 안홍석 on 2020/02/18.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    var cityName: String?
    
    var stateImage: UIImage?
    var cityState: Int?
    var cityTemp: String?
    var cityRain: String?

    @IBOutlet var image: UIImageView!
    @IBOutlet var state: UILabel!
    @IBOutlet var temper: UILabel!
    @IBOutlet var rain: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = self.cityName
        print("\(cityName!)")

    }
    
    func addViews() {
        self.addImage()
        self.addState()
        self.addTemper()
        self.addRain()
    }
    
    func addImage() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        
        image.image = stateImage
        
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        image.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        self.image = image
    }
    
    func addState() {
        let state: UILabel = UILabel()
        state.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(state)
        
        var stateToString: String = ""
        switch cityState {
        case 10:
            stateToString = "맑음"
        case 11:
            stateToString = "흐림"
        case 12:
            stateToString = "비"
        case 13:
            stateToString = "눈"
        default:
            print("error")
        }
        
        state.text = "\(stateToString)"
        state.textColor = UIColor.black
        state.textAlignment = NSTextAlignment.center
        state.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        state.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        state.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 32).isActive = true
        state.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        self.state = state
    }
    
    func addTemper() {
        let temp: UILabel = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(temp)
        
        temp.text = cityTemp!
        temp.textColor = UIColor.black
        temp.textAlignment = NSTextAlignment.center
        temp.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        
        temp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: self.state.bottomAnchor, constant: 16).isActive = true
        temp.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        
        self.temper = temp
    }
    
    func addRain() {
        let rain: UILabel = UILabel()
        rain.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(rain)
        
        rain.text = cityRain!
        rain.textColor = UIColor.systemYellow
        rain.textAlignment = NSTextAlignment.center
        rain.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        
        rain.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        rain.topAnchor.constraint(equalTo: self.temper.bottomAnchor, constant: 8).isActive = true
        rain.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        
        self.rain = rain
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
