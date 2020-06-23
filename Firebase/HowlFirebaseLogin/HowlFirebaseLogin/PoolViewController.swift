//
//  PoolViewController.swift
//  SwimmingPool
//
//  Created by 안홍석 on 2020/05/07.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

class PoolViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier: String = "poolCell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    var scale: CGFloat!
    var targetX: CGFloat!
    var details: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scale = UIScreen.main.scale
        targetX = (UIScreen.main.bounds.width) * scale / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        OperationQueue.main.addOperation {
            self.collectionView?.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: PoolCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PoolCollectionViewCell else {
            return PoolCollectionViewCell()
        }
        
        cell.backgroundColor = UIColor.black
        
        return cell
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
