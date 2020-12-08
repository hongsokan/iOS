//
//  ImageViewController.swift
//  MyAlbum
//
//  Created by 안홍석 on 2020/11/05.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    
    var touchGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    var isImageFavorite: Bool = false
    var selectedAsset: PHAsset?
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var isShowingAllItems: Bool?
    var isClickedDeleteButton: Bool = false
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var displayPhotoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isShowingAllItems = true
        
        self.setScrollView()
        self.setImageView()
        self.addGestureToThisView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let favorite = self.selectedAsset?.isFavorite else {
            return
        }
        
        self.isImageFavorite = favorite
        
        self.setNaviTitle()
        self.setImage()
        self.setFavoriteButtonTint()
        
        self.isShowingAllItems = true
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.navigationBar.isHidden = false
        
        PHPhotoLibrary.shared().register(self)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
}




extension PhotoViewController {
    
    
    func setScrollView() {
        self.photoScrollView.maximumZoomScale = 3
        self.photoScrollView.minimumZoomScale = 1
        self.photoScrollView.delegate = self
        self.photoScrollView.isScrollEnabled = true
        self.photoScrollView.contentMode = .scaleAspectFit
    }
    
    
    func setImageView() {
        self.displayPhotoImageView.contentMode = .scaleAspectFit
    }
    
    
    func addGestureToThisView() {
        self.touchGesture = UITapGestureRecognizer(target: self, action: #selector(touchImage))
        self.view.addGestureRecognizer(self.touchGesture)
    }
    
    
    func setFavoriteButtonTint() {
        if self.isImageFavorite {
            //red
            OperationQueue.main.addOperation{
                self.favoriteButton.tintColor = UIColor.red
            }
        } else {
            //black
            OperationQueue.main.addOperation{
                self.favoriteButton.tintColor = UIColor.black
            }
        }
    }
    
    
    // Referenced by https://stackoverflow.com/questions/38626004/add-subtitle-under-the-title-in-navigation-bar-controller-in-xcode
    func setNaviTitle() {
        guard let selectedAsset = self.selectedAsset else {
            return
        }
        
        guard let creationDate = selectedAsset.creationDate else {
            return
        }
        
        // Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: creationDate)
        
        // Time
        dateFormatter.dateFormat = "a hh:mm:ss"
        let time = dateFormatter.string(from: creationDate)
        
        // Date Label
        let dateLabel: UILabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.text = date
        dateLabel.textColor = UIColor.black
        dateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        dateLabel.sizeToFit()
        
        //Time Label
        let timeLabel: UILabel = UILabel()
        timeLabel.textAlignment = .center
        timeLabel.text = time
        timeLabel.textColor = UIColor.gray
        timeLabel.font = UIFont.boldSystemFont(ofSize: 10)
        timeLabel.sizeToFit()
        
        // Title View
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(dateLabel.frame.size.width, timeLabel.frame.size.width), height: 40))
        
        titleView.addSubview(dateLabel)
        titleView.addSubview(timeLabel)
        
        dateLabel.frame = CGRect(x: (titleView.frame.size.width/2) - (dateLabel.frame.size.width/2), y: 0, width: dateLabel.frame.size.width, height: dateLabel.frame.size.height)
        timeLabel.frame = CGRect(x: (titleView.frame.size.width/2) - (timeLabel.frame.size.width/2), y: dateLabel.frame.size.height, width: timeLabel.frame.size.width, height: timeLabel.frame.size.height)
        
        self.navigationItem.titleView = titleView
    }
    
    
    func setImage() {
        guard let asset = self.selectedAsset else {
            return
        }
        
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        
        self.imageManager.requestImage(for: asset, targetSize: CGSize(width: self.displayPhotoImageView.frame.width , height: self.displayPhotoImageView.frame.height), contentMode: .aspectFit, options: options, resultHandler: {
            image, _ in
            self.displayPhotoImageView.image = image
        })
    }
    
    
    func removePhoto() {
        guard let asset:PHAsset = self.selectedAsset else {
            return
        }
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets([asset] as NSArray)}, completionHandler: {(success, error) in
            OperationQueue.main.addOperation {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    func setFavoriteStatus()  {
        guard let selectedAsset: PHAsset = self.selectedAsset else {
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
                                                PHAssetChangeRequest(for: selectedAsset).isFavorite = !self.isImageFavorite}, completionHandler: {(success, error) in
                                                    if success {
                                                        self.isImageFavorite = !self.isImageFavorite
                                                    } else {
                                                        print("\(String(describing: error?.localizedDescription))")
                                                    }
                                                })
    }
    
    
    // MARK: - activityViewController Methods
    func createUIActivityViewController() {
        guard let asset: PHAsset = self.selectedAsset else {
            return
        }
        
        var imageToShare: [UIImage] = []
        
        let options : PHImageRequestOptions = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        options.isSynchronous = true
        
        self.imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth , height: asset.pixelHeight), contentMode: .aspectFit, options: options, resultHandler: {
            image, _ in
            guard let img: UIImage = image else {
                return
            }
            imageToShare.append(img)
        })
        
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func clickFavoriteButton(_ sender: Any) {
        self.setFavoriteStatus()
    }
    
    
    @IBAction func clickShareButton(_ sender: Any) {
        self.createUIActivityViewController()
    }
    
    
    @IBAction func clickDeleteButton(_ sender: Any) {
        self.isClickedDeleteButton = true
        self.removePhoto()
    }
}




extension PhotoViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        if isClickedDeleteButton {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            let changes = changeInstance.changeDetails(for: self.selectedAsset ?? PHAsset.init())
            self.selectedAsset = changes?.objectAfterChanges
            self.setFavoriteButtonTint()
        }
    }
}




// MARK: ScrollView Methods
extension PhotoViewController: UIScrollViewDelegate {
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.displayPhotoImageView
    }
    
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.isShowingAllItems = false
        
        guard let isShowing: Bool = self.isShowingAllItems else {
            return
        }
        
        self.dismissOrShowItemsOnViewController(isShowing)
    }
    
    
    // MARK: - A Tap Gesture Recognizer method
    @objc func touchImage(_ sender: Any) {
        guard let isShowing: Bool = self.isShowingAllItems else {
            return
        }
        self.dismissOrShowItemsOnViewController(!isShowing)
        
        self.isShowingAllItems = !isShowing
    }
    
    
    func dismissOrShowItemsOnViewController(_ isShowing: Bool) {
        self.navigationController?.setToolbarHidden(!isShowing, animated: false)
        self.navigationController?.navigationBar.isHidden = !isShowing
    }
}
