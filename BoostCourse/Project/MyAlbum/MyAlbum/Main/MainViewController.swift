//
//  ViewController.swift
//  MyAlbum
//
//  Created by 안홍석 on 2020/11/04.
//

// 프로젝트 참고 자료
// https://github.com/iosdevbyul/MyAlbum

import UIKit
import Photos

class MainViewController: UIViewController {
    
    // List all photo albums in iOS -  https://stackoverflow.com/questions/36713164/list-all-photo-albums-in-ios
    struct AlbumModel {
        let name: String
        let count: Int
        let collection: PHAssetCollection
        init(name: String, count: Int, collection: PHAssetCollection) {
            self.name = name
            self.count = count
            self.collection = collection
        }
    }
    
    var albumNameList: [String] = []
    var albumCountList: [Int] = []
    var albumCollectionList: [PHAssetCollection] = []
    
    var fetchResult: [PHFetchResult<PHAsset>] = []
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    var selectedCellIndex: Int = 0
    var cellSize: CGSize?
    let cellIdentifier = "mainCollectionViewCell"
    let segueIdentifier: String = "gotoPhotoList"
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "앨범"
        self.requestPhotoAuthority()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestCollection()
        self.mainCollectionView.reloadData()
        self.navigationController?.setToolbarHidden(true, animated: false)
        PHPhotoLibrary.shared().register(self)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let nextViewController = segue.destination as? AlbumViewController else {
                return
            }
            nextViewController.fetchResult = self.fetchResult[selectedCellIndex]
            nextViewController.navigationItem.title = albumNameList[selectedCellIndex]
            nextViewController.assetCollection = albumCollectionList[selectedCellIndex]
        }
    }
}




// MARK: CollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumCollectionList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }
        
        if self.albumCollectionList.count <= 0 {
            return UICollectionViewCell()
        }
        
        let asset: PHAsset = self.fetchResult[indexPath.item].object(at: 0)
        
        guard let cellWidth = self.cellSize?.width else {
            return cell
        }
        
        cell.albumImageView.frame = CGRect(x: 8, y: 8, width: cellWidth-16, height: cellWidth-16)
        cell.albumImageView.clipsToBounds = true
        cell.albumNameLabel.frame = CGRect(x: 8, y: cellWidth + 5, width: cellWidth - 10, height: 20)
        cell.albumNameLabel.text = self.albumNameList[indexPath.item]
        cell.albumCountLabel.frame = CGRect(x: 8, y: cellWidth + 30, width: cellWidth - 10, height: 20)
        cell.albumCountLabel.text = "\(albumCountList[indexPath.item])"
        
        OperationQueue().addOperation {
            self.imageManager.requestImage(for: asset, targetSize: CGSize(width: cellWidth, height: cellWidth), contentMode: .aspectFill, options: nil, resultHandler: {
                image, _ in
                OperationQueue.main.addOperation {
                    cell.albumImageView.image = image
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
        if ((orientation == .landscapeLeft) || (orientation == .landscapeRight)) {
            screenWidth = UIScreen.main.bounds.height
        } else { //portrait
            screenWidth = UIScreen.main.bounds.width
        }
        let appropriateCellWidth = (screenWidth - (screenWidth * 0.1)) / 2
        let appropriateCellHeight = appropriateCellWidth + 50
        
        cellSize = CGSize(width: appropriateCellWidth, height: appropriateCellHeight)
        
        self.cellSize = cellSize
        return cellSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.item
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}




// MARK: Methods
extension MainViewController {
    
    // 출처: https://stackoverflow.com/questions/36713164/list-all-photo-albums-in-ios
    func requestCollection() {
        self.fetchResult.removeAll()
        self.albumNameList.removeAll()
        self.albumCountList.removeAll()
        self.albumCollectionList.removeAll()
        
        var album: [AlbumModel] = [AlbumModel]()
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        
        // To detect empty albums
        var originalNewAlbum: [AlbumModel] = [AlbumModel]()
        
        userAlbums.enumerateObjects { object, index, stop in
            let obj: PHAssetCollection = object
            
            var assetCount = obj.estimatedAssetCount
            
            if assetCount == NSNotFound {
                let fetchOptions = PHFetchOptions()
                fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
                assetCount = PHAsset.fetchAssets(in: obj, options: fetchOptions).count
            }
            
            guard let localizedTitle = obj.localizedTitle else {
                return
            }
            let newAlbum = AlbumModel(name: localizedTitle, count: assetCount, collection:obj)
            originalNewAlbum.append(newAlbum)
            
            if (assetCount > 0) {
                let newAlbum = AlbumModel(name: localizedTitle, count: assetCount, collection:obj)
                album.append(newAlbum)
            }
        }
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        for item in album {
            albumNameList.append(item.name)
            albumCountList.append(item.count)
            albumCollectionList.append(item.collection)
        }
        
        for i in 0..<originalNewAlbum.count {
            // if the stored album is not empty, executes the process to append
            if originalNewAlbum[i].count != 0 {
                self.fetchResult.append(PHAsset.fetchAssets(in: userAlbums.object(at: i), options: fetchOption))
            }
        }
    }
    
    
    // info.plist -> Photo Library Usage Description
    func requestPhotoAuthority() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가")
            self.requestCollection()
            OperationQueue.main.addOperation {
                self.mainCollectionView?.reloadData()
            }
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("사용자가 허용")
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.mainCollectionView?.reloadData()
                    }
                case .denied:
                    print("사용자가 불허")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        default:
            print("알 수 없는 오류")
            fatalError()
        }
    }
}




// MARK: PHPhotoLibraryChangeObserver
extension MainViewController: PHPhotoLibraryChangeObserver {
    /// - Tag: RespondToChanges
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        self.requestCollection()
        OperationQueue.main.addOperation {
            self.mainCollectionView.reloadData()
        }
    }
}
