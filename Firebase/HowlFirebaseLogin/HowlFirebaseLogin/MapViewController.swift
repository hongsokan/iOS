//
//  MapViewController.swift
//  SwimmingPool
//
//  Created by 안홍석 on 2020/05/07.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setMapView()

        // Do any additional setup after loading the view.
    }
    
    func setMapView() {
        let map: MKMapView = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(map)
        
        map.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        map.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        map.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.mapView = map
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
