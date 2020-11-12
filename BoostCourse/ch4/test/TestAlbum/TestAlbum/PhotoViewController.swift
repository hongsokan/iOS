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


class PhotoViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var actionButton: UIBarButtonItem!
    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet var trashButton: UIBarButtonItem!
    
    var seletedImage: UIImage!
    var dateInfo: Date!
    
    var asset: PHAsset!
    var assetCollection: PHAssetCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print("\(String(describing: dateInfo))")
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString: String = dateFormatter.string(from: dateInfo)
        
        dateFormatter.dateFormat = "a HH:mm:ss"
        let timeString: String = dateFormatter.string(from: dateInfo)
        
        let titleView: UILabel = {
            let titleView = UILabel()
            titleView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            titleView.numberOfLines = 2
            titleView.text = dateString + "\n" + timeString
            
            return titleView
        }()
        
        self.navigationItem.titleView = titleView
        
        self.navigationController?.isToolbarHidden = false
        
        actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButton(_:)))
        
        //        favoriteButton = UIBarButtonItem(barButtonSystemItem: nil, target: self, action: #selector(favoriteButton(_:)))
        
        favoriteButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(favoriteButton(_:)))
        
        favoriteButton.isEnabled = asset.canPerform(.properties)
        favoriteButton.title = asset.isFavorite ? "♥︎" : "♡"
        
        trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashButton(_:)))
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.setToolbarItems([actionButton, spaceItem, favoriteButton, spaceItem, trashButton], animated: false)
        
        self.addImage()
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.doPinch(_:)))
        
        self.view.addGestureRecognizer(pinch)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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


// MARK: PHPhotoLibraryChangeObserver
extension PhotoViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // The call might come on any background queue. Re-dispatch to the main queue to handle it.
        DispatchQueue.main.sync {
            // Check if there are changes to the displayed asset.
            guard let details = changeInstance.changeDetails(for: asset) else { return }
            
            // Get the updated asset.
            asset = details.objectAfterChanges
            
            // If the asset's content changes, update the image and stop any video playback.
            if details.assetContentChanged {
                updateImage()
                
                //                playerLayer?.removeFromSuperlayer()
                //                playerLayer = nil
            }
        }
    }
}

/*
 // MARK: PHPhotoLibraryChangeObserver
 extension PhotoViewController: PHPhotoLibraryChangeObserver {
 func photoLibraryDidChange(_ changeInstance: PHChange) {
 
 guard let changes = changeInstance.changeDetails(for: self.fetchResult) else {   return  }
 
 self.fetchResult = changes.fetchResultAfterChanges
 
 OperationQueue.main.addOperation {
 self.secondCollectionView?.reloadSections(IndexSet(0...0))
 }
 }
 }
 */



// MARK: Methods
extension PhotoViewController {
    
    
    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        image.transform = image.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
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
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest(for: self.asset)
            request.isFavorite = !self.asset.isFavorite
        }, completionHandler: { success, error in
            if success {
                DispatchQueue.main.sync {
                    sender.title = self.asset.isFavorite ? "♥︎" : "♡"
                }
            } else {
                print("Can't mark the asset as a Favorite: \(String(describing: error))")
            }
        })
    }
    
    @IBAction func trashButton(_ sender: UIBarButtonItem) {
        let completion = { (success: Bool, error: Error?) -> Void in
            if success {
                PHPhotoLibrary.shared().unregisterChangeObserver(self)
                DispatchQueue.main.sync {
                    _ = self.navigationController!.popViewController(animated: true)
                }
            } else {
                print("Can't remove the asset: \(String(describing: error))")
            }
        }
        if assetCollection != nil {
            // Remove the asset from the selected album.
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetCollectionChangeRequest(for: self.assetCollection)!
                request.removeAssets([self.asset] as NSArray)
            }, completionHandler: completion)
        } else {
            // Delete the asset from the photo library.
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets([self.asset] as NSArray)
            }, completionHandler: completion)
        }
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
    
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: self.image.bounds.width * scale, height: self.image.bounds.height * scale)
    }
    
    func updateImage() {
        if asset.mediaSubtypes.contains(.photoLive) {
            updateStaticImage()
        }
    }
    
    func updateStaticImage() {
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.progressHandler = { progress, _, _, _ in
            // The handler may originate on a background queue, so
            // re-dispatch to the main queue for UI work.
            DispatchQueue.main.sync {
                //                self.progressView.progress = Float(progress)
            }
        }
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options,
                                              resultHandler: { image, _ in
                                                // PhotoKit finished the request, so hide the progress view.
                                                //                                                self.progressView.isHidden = true
                                                
                                                // If the request succeeded, show the image view.
                                                guard let image = image else { return }
                                                
                                                // Show the image.
                                                //                                                self.livePhotoView.isHidden = true
                                                self.image.isHidden = false
                                                self.image.image = image
        })
    }
}
