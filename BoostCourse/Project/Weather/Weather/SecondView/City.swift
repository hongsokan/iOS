//
//  City.swift
//  Weather
//
//  Created by 안홍석 on 2020/02/18.
//  Copyright © 2020 안홍석. All rights reserved.
//

import Foundation


struct City: Codable {
    
    let cityName: String
    let state: Int
    let celsius: Float
    let rainfall: Int
    
    var fahrenheit: Float {
        return celsius * (9/5) + 32
    }
    
    enum CodingKeys: String, CodingKey {
        case state, celsius
        case cityName = "city_name"
        case rainfall = "rainfall_probability"
    }
    
    // state == 10 sunny
    // state == 11 cloudy
    // state == 12 rainy
    // state == 13 snowy
}
