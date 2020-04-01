//
//  PhotoViewController.swift
//  TestAlbum
//
//  Created by 안홍석 on 2020/03/15.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Photos
import Foundation


class PhotoViewController: UIViewController {

    
    @IBOutlet var image: UIImageView!
    
    var seletedImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.navigationItem.title = "yyyy-MM-dd"
        print("\(image.description)")
        self.navigationController?.isToolbarHidden = false
        
        let actionItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButton(_:)))
        
        let checkItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(checkButton(_:)))
        
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButton(_:)))
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.setToolbarItems([actionItem, spaceItem, checkItem, spaceItem, deleteItem], animated: false)
        
        self.addImage()
    }
    
    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        let imageToShare: UIImage = UIImage(named: "default")!
        let urlToShare: String = "http://edwith.org/boostcourse-ios"
        let textToShare: String = "부스트코스"
        
        let activityViewController = UIActivityViewController(activityItems: [imageToShare, urlToShare, textToShare], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                
            } else {
                
            }
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func checkButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
        
    }
    
    func addImage() {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(image)
        
        image.image = seletedImage
        
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        image.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        self.image = image
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
