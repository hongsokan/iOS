//
//  AlbumViewController.swift
//  MyAlbum
//
//  Created by 안홍석 on 2020/11/05.
//

import UIKit
import Photos

class AlbumViewController: UIViewController {
    
    var assetCollection: PHAssetCollection!
    var fetchResult: PHFetchResult<PHAsset>?
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    var selectButton: UIBarButtonItem?
    var selectedMode: Bool = true
    var selectedAssets: [PHAsset] = []
    var selectedAsset: PHAsset?
    var selectedAssetIndex: [Int] = []
    var selectedIndexPath: [IndexPath] = []
    
    var initTitle: String?
    var isLatest: Bool = true
    
    let cellIdentifier: String = "photoCell"
    var cellSize: CGSize?
    var selectedCellIndex: Int = 0
    let segueIdentifier: String = "gotoPhoto"
    
    @IBOutlet weak var albumCollectionView: UICollectionView!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var orderButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSelectButton()
        self.initTitle = self.navigationItem.title
        
        PHPhotoLibrary.shared().register(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.deleteButton.isEnabled = false
        self.actionButton.isEnabled = false
        self.selectedMode = false
        
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if !selectedMode {
            if segue.identifier == segueIdentifier {
                guard let nextViewController: PhotoViewController = segue.destination as? PhotoViewController else {
                    return
                }
                
                guard let fetchResult = self.fetchResult else {
                    return
                }
                
                nextViewController.selectedAsset = fetchResult.object(at: selectedCellIndex)
            }
        }
    }
    
}




// MARK: CollectionView
extension AlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AlbumCollectionViewCell = self.albumCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let fetchResult = self.fetchResult else {
            return cell
        }
        
        guard let size = self.cellSize?.width else {
            return cell
        }
        
        var asset: PHAsset = fetchResult.object(at: indexPath.item)
        asset = fetchResult.object(at: indexPath.item)
        
        cell.photoImageView.frame = CGRect(x: 2, y: 2, width: size-4, height: size-4)
        cell.photoImageView.clipsToBounds = true
        if isThisSelectedItem(self.selectedAssetIndex, indexPath.item) {
            cell.backgroundColor = UIColor.black
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        OperationQueue().addOperation {
            self.imageManager.requestImage(for: asset,
                                           targetSize: CGSize(width: size, height: size),
                                           contentMode: .aspectFill,
                                           options: nil,
                                           resultHandler: {
                                            image, _ in
                                            OperationQueue.main.addOperation {
                                                cell.photoImageView?.image = image
                                            }
                                            
                                           })
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        var screenWidth: CGFloat = 0
        var cellSize: CGSize = CGSize()
        
        //landscape
        if (orientation == .landscapeLeft || orientation == .landscapeRight) {
            screenWidth = UIScreen.main.bounds.height
        } else { //portrait
            screenWidth = UIScreen.main.bounds.width
        }
        let appropriateCellWidth = (screenWidth - 50) / 3
        cellSize = CGSize(width: appropriateCellWidth, height: appropriateCellWidth)
        
        self.cellSize = cellSize
        return self.cellSize ?? CGSize.init(width: 0, height: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedMode {
            if isThisSelectedItem(self.selectedAssetIndex, indexPath.item) {
                let index: Int = getIndexFromSelctedItem(self.selectedAssetIndex,indexPath.item)
                if(index != -1) {
                    self.selectedAssetIndex.remove(at: index)
                    self.selectedAssets.remove(at: index)
                    self.selectedIndexPath.remove(at: index)
                }
                if self.selectedAssetIndex.count == 0 {
                    self.deleteButton.isEnabled = false
                    self.actionButton.isEnabled = false
                }
            } else {
                self.selectedAssetIndex.append(indexPath.item)
                guard let fetchResult = fetchResult else {
                    return
                }
                self.selectedAsset = fetchResult.object(at: indexPath.item)
                guard let selectAsset = self.selectedAsset else {
                    return
                }
                self.selectedAssets.append(selectAsset)
                self.selectedIndexPath.append(indexPath)
                self.deleteButton.isEnabled = true
                self.actionButton.isEnabled = true
            }
            
            if self.selectedAssetIndex.count == 0 {
                self.title = "선택된 사진"
            } else {
                self.title = "\(self.selectedAssetIndex.count) " + "장의 사진이 선택되었습니다"
            }
            albumCollectionView.reloadItems(at: [indexPath])
        } else {
            self.selectedCellIndex = indexPath.item
            self.performSegue(withIdentifier: segueIdentifier, sender: self)
        }
    }
    
    
    func isThisSelectedItem(_ selectedAssetIndex: [Int], _ currentItemIndex: Int) -> Bool {
        for i in 0..<self.selectedAssetIndex.count {
            if selectedAssetIndex[i] == currentItemIndex {
                return true
            }
        }
        return false
    }
    
    
    func getIndexFromSelctedItem(_ selectedAssetIndex: [Int], _ currentItemIndex: Int) -> Int {
        var returnIndex: Int = -1
        for i in 0..<self.selectedAssetIndex.count {
            if selectedAssetIndex[i] == currentItemIndex {
                returnIndex = i
                return returnIndex
            }
        }
        return returnIndex
    }
}




extension AlbumViewController {
    
    
    func setSelectButton() {
        self.selectButton = UIBarButtonItem(title: "선택", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.selectPhoto(_:)))
        self.navigationItem.rightBarButtonItem = self.selectButton
    }
    
    
    func resetSelectButton() {
        selectedMode = !selectedMode
        if selectedMode == true {
            self.selectButton?.title = "취소"
            self.title = "사진 선택"
            self.navigationItem.setHidesBackButton(true, animated:true);
            self.albumCollectionView.allowsMultipleSelection = true
        } else {
            self.navigationItem.title = initTitle
            self.selectButton?.title = "선택"
            self.navigationItem.setHidesBackButton(false, animated:true);
            
            self.albumCollectionView.allowsMultipleSelection = false
            
            self.deleteButton.isEnabled = false
            self.actionButton.isEnabled = false
        }
        self.selectedAssets.removeAll()
        self.selectedAssetIndex.removeAll()
        self.albumCollectionView.reloadItems(at: self.selectedIndexPath)
        self.selectedIndexPath.removeAll()
    }
    
    
    @objc func selectPhoto(_ sender: UIBarButtonItem) {
        self.resetSelectButton()
    }
    
    
    @IBAction func reorderPhotos(_ sender: Any) {
        let fetchOption: PHFetchOptions = PHFetchOptions()
        
        if self.isLatest {
            self.orderButton.title = "오래된 순"
            self.isLatest = false
            fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        } else {
            self.orderButton.title = "최신 순"
            self.isLatest = true
            fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        }
        
        guard let assetCollection = self.assetCollection else {
            return
        }
        
        self.fetchResult = PHAsset.fetchAssets(in: assetCollection, options: fetchOption)
        OperationQueue.main.addOperation {
            self.albumCollectionView.reloadData()
        }
    }
    
    
    @IBAction func sendPhotos(_ sender: Any) {
        // Prepare images the user selected to share
        var imagesToShare: [UIImage] = []
        
        let options : PHImageRequestOptions = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        options.isSynchronous = true
        
        for i in 0..<self.selectedAssets.count {
            self.imageManager.requestImage(for: self.selectedAssets[i],
                                           targetSize: CGSize(width: self.selectedAssets[i].pixelWidth, height: self.selectedAssets[i].pixelHeight),
                                      contentMode: .aspectFill,
                                      options: options, resultHandler: {
                                        image, _ in
                                        guard let image: UIImage = image else {
                                            return
                                        }
                                        imagesToShare.append(image)
                                      })
        }
        
        let activityViewController = UIActivityViewController(activityItems: imagesToShare, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.selectedMode = true
                self.resetSelectButton()
                
                OperationQueue.main.addOperation {
                    self.albumCollectionView.reloadData()
                }
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func deletePhoto(_ sender: Any) {
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets(self.selectedAssets as NSArray)}, completionHandler:
                                                {(success, error) in
                                                    if success {
                                                        OperationQueue.main.addOperation {
                                                            self.resetSelectButton()
                                                        }
                                                    } else {
                                                        print("\(String(describing: error?.localizedDescription))")
                                                    }
                                                })
    }
}




// MARK: PHPhotoLibraryChangeObserver
extension AlbumViewController: PHPhotoLibraryChangeObserver {
    
    /// - Tag: RespondToChanges
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let fetchResult = self.fetchResult else {
            return
        }
        
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        
        self.fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.albumCollectionView.reloadData()
        }
    }
}
