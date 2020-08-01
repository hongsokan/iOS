//
//  SecondCustomCell.swift
//  Weather
//
//  Created by 안홍석 on 2020/02/18.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class SecondCustomCell: UITableViewCell {

    @IBOutlet var leftImage: UIImageView!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var cityTemperature: UILabel!
    @IBOutlet var cityRain: UILabel!
    
    var stateForCity: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
