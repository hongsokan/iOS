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

    private weak var imageView: UIImageView!
    private weak var stateLabel: UILabel!
    private weak var temperLabel: UILabel!
    private weak var rainLabel: UILabel!
    
    var imageWidth: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addViews()
        
        self.navigationItem.title = self.cityName
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIApplication.shared.windows.first?
            .windowScene?.interfaceOrientation.isPortrait == true {
            if imageView != nil {
                imageWidth.isActive = false
                imageWidth = imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1)
                imageWidth.isActive = true
            }
        }
        
        if UIApplication.shared.windows.first?
            .windowScene?.interfaceOrientation.isLandscape == true {
            if imageView != nil {
                imageWidth.isActive = false
                imageWidth = imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3)
                imageWidth.isActive = true
            }
        }
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
}




// MARK: View
extension ThirdViewController {
    
    func addViews() {
        self.addImageView()
        self.addStateLabel()
        self.addTemperLabel()
        self.addRainLabel()
    }
    
    
    func addImageView() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(image)
        
        image.image = stateImage
        
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        imageWidth = image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3)
        imageWidth.isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1).isActive = true
        
        self.imageView = image
    }
    
    
    func addStateLabel() {
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
            print("날씨 상태를 알 수 없음")
        }
        
        state.text = "\(stateToString)"
        state.textColor = .black
        state.textAlignment = NSTextAlignment.center
        state.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        state.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        state.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 32).isActive = true
        
        self.stateLabel = state
    }
    
    
    func addTemperLabel() {
        let temp: UILabel = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(temp)
        
        temp.text = cityTemp ?? "온도 : 알 수 없음"
        temp.textColor = .black
        temp.textAlignment = NSTextAlignment.center
        temp.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        
        temp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: self.stateLabel.bottomAnchor, constant: 16).isActive = true
        
        self.temperLabel = temp
    }
    
    
    func addRainLabel() {
        let rain: UILabel = UILabel()
        rain.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rain)
        
        rain.text = cityRain ?? "강수확률 : 알 수 없음"
        let rainPercent =
            Int(cityRain?.components(separatedBy: [" ", "%"])[1] ?? "") ?? 0
        if rainPercent > 50 {
            rain.textColor = .systemOrange
        }
        
        rain.textAlignment = NSTextAlignment.center
        rain.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        
        rain.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        rain.topAnchor.constraint(equalTo: self.temperLabel.bottomAnchor, constant: 8).isActive = true
        
        self.rainLabel = rain
    }
}
