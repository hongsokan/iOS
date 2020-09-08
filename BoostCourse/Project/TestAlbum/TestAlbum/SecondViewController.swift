//
//  SecondViewController.swift
//  TestAlbum
//
//  Created by 안홍석 on 2020/03/12.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var myAlbum: AlbumModel = AlbumModel(name: "", count: 0, collection: PHAssetCollection.init())
    
    let cellIdentifier: String = "photoCell"
    @IBOutlet weak var secondCollectionView: UICollectionView!
    var selectedCells: [IndexPath]!
    
    var scale: CGFloat!
    var targetX: CGFloat!
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    var fetchOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        return fetchOptions
    }
    
    @IBOutlet var selectButton: UIBarButtonItem!
    @IBOutlet var actionButton: UIBarButtonItem!
    @IBOutlet var sortingButton: UIBarButtonItem!
    @IBOutlet var deleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 사용자가 사진첩 접근을 허용했는지 판단
        // 사용자의 프라이버시에 접근
        // info.plist 에서 Photo Library Usage 메시지 작성
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가")
            self.requestCollection()
            self.secondCollectionView?.reloadData()
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
                        self.secondCollectionView?.reloadData()
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
        
        // PhotoLibrary가 변화될 때마다 델리게이트 메서드가 호출된다
        PHPhotoLibrary.shared().register(self)
        
        self.navigationController?.isToolbarHidden = false
        
        self.navigationItem.title = myAlbum.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectingPhoto(_:)))
        selectButton = self.navigationItem.rightBarButtonItem
        self.secondCollectionView?.allowsMultipleSelection = true
        
        actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButton(_:)))
        actionButton.isEnabled = false
        
        sortingButton = UIBarButtonItem(title: "최신순", style: .plain, target: self, action: #selector(sortingStatus(_:)))
        
        deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButton(_:)))
        deleteButton.isEnabled = false
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.setToolbarItems([actionButton, spaceItem, sortingButton, spaceItem, deleteButton], animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /*
    // PHPhotoLibraryChangeObserver, 상태 변화 감지 메서드 추가, 바뀌었으면 테이블뷰 다시 로드
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: self.fetchResult) else {   return  }
        
        self.fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.secondCollectionView?.reloadSections(IndexSet(0...0))
        }
    }   */
    
    
    func requestCollection() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        self.fetchResult = PHAsset.fetchAssets(in: myAlbum.collection, options: fetchOptions)
        
        OperationQueue.main.addOperation {
            self.secondCollectionView.reloadData()
        }
        
    }
    
    /*
     override func setEditing(_ editing: Bool, animated: Bool) {
     super.setEditing(editing, animated: animated)
     
     secondCollectionView.allowsMultipleSelection = editing
     let indexPaths = secondCollectionView.indexPathsForVisibleItems
     for indexPath in indexPaths {
     let cell = secondCollectionView.cellForItem(at: indexPath) as! SecondCollectionViewCell
     cell.isInEditingMode = editing
     }
     }   */
    
    
    @IBAction func selectingPhoto(_ sender: UIBarButtonItem) {
        if sender.title == "선택" {
            sender.title = "취소"
            self.navigationItem.title = "항목 선택"
            self.secondCollectionView.allowsMultipleSelection = true
            selectedCells = self.secondCollectionView?.indexPathsForSelectedItems
            for indexPath in selectedCells {
                let cell = self.secondCollectionView.cellForItem(at: indexPath) as! SecondCollectionViewCell
                cell.isInEditingMode = true
//                if cell.isSelected {
                
//                }
                deleteButton.isEnabled = true
                actionButton.isEnabled = true
            }
        } else {
            sender.title = "선택"
            self.navigationItem.title = myAlbum.name
            selectedCells = self.secondCollectionView?.indexPathsForSelectedItems
            for indexPath in selectedCells {
                let cell = self.secondCollectionView.cellForItem(at: indexPath) as! SecondCollectionViewCell
                cell.isInEditingMode = false
                deleteButton.isEnabled = false
                actionButton.isEnabled = false
            }
        }
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
    
    @IBAction func sortingStatus(_ sender: UIBarButtonItem) {
        
        let fetchOptions = PHFetchOptions()
        
        if sender.title == "최신순" {
            sender.title = "과거순"
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            self.fetchResult = PHAsset.fetchAssets(in: myAlbum.collection, options: fetchOptions)
            OperationQueue.main.addOperation {
                self.secondCollectionView.reloadData()
            }
        } else {
            sender.title = "최신순"
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.fetchResult = PHAsset.fetchAssets(in: myAlbum.collection, options: fetchOptions)
            OperationQueue.main.addOperation {
                self.secondCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        print(myAlbum.count)
        
        return self.fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SecondCollectionViewCell = secondCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! SecondCollectionViewCell
        
        // asset 은 fetchResult 에서 인덱스에 해당
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: secondCollectionView.frame.width / 3, height: secondCollectionView.frame.width / 3), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            
            //            cell.backgroundColor = UIColor.systemBlue
            cell.imageDate = asset.creationDate
            cell.photoImage?.image = image
        })
        
        return cell
    }
    
    // cell 의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        targetX = secondCollectionView.frame.width / 3 - 2 // Min Spacing For Cell
        
        //        print("Cell 크기 설정 - targetX = \(String(describing: targetX))")
        
        return CGSize(width: targetX, height: targetX)
    }
    
    // cell 간의 가로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2 as CGFloat
    }
    
    // cell 간의 세로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2 as CGFloat
    }
    
    // cell 다중 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.secondCollectionView?.allowsMultipleSelection = true
    }
    
    //
    
    //    func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
    //        <#code#>
    //    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let photoViewController: PhotoViewController = segue.destination as? PhotoViewController else { return }
        let cell: SecondCollectionViewCell = sender as! SecondCollectionViewCell
        let indexPath = secondCollectionView.indexPath(for: cell)!
        
        photoViewController.asset = fetchResult.object(at: indexPath.item)
        photoViewController.assetCollection = myAlbum.collection
        
        photoViewController.seletedImage = cell.photoImage?.image
        photoViewController.dateInfo = cell.imageDate
    }
    
    
}



// MARK: PHPhotoLibraryChangeObserver
extension SecondViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        /*
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
        */
        
        guard let changes = changeInstance.changeDetails(for: self.fetchResult) else {   return  }
        
        self.fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.secondCollectionView?.reloadSections(IndexSet(0...0))
        }
    }
}
