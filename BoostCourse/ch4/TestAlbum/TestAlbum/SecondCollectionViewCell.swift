//
//  SecondCollectionViewCell.swift
//  TestAlbum
//
//  Created by 안홍석 on 2020/03/12.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Photos

class SecondCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImage: UIImageView!
    var imageDate: Date!
    
    var isInEditingMode: Bool = false {
        didSet {
            layer.borderWidth = 0
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                layer.borderWidth = 5
            }
        }
    }
}
