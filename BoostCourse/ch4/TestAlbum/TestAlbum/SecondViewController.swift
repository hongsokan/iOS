//
//  SecondViewController.swift
//  TestAlbum
//
//  Created by 안홍석 on 2020/03/12.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver {
    
    let cellIdentifier: String = "photoCell"
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    var myAlbum: AlbumModel = AlbumModel(name: "", count: 0, collection: PHAssetCollection.init())
    
    var scale: CGFloat!
    var targetX: CGFloat!
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    var fetchOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        return fetchOptions
    }
    
    // PHPhotoLibraryChangeObserver, 상태 변화 감지 메서드 추가, 바뀌었으면 테이블뷰 다시 로드
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: self.fetchResult) else {   return  }
        
        self.fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.secondCollectionView?.reloadSections(IndexSet(0...0))
        }
    }
    
    
    func requestCollection() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        self.fetchResult = PHAsset.fetchAssets(in: myAlbum.collection, options: fetchOptions)
        
        OperationQueue.main.addOperation {
            self.secondCollectionView.reloadData()
        }
        
    }
    
    
    
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
        
        self.navigationItem.title = myAlbum.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectingPhoto(_:)))
        
        self.navigationController?.isToolbarHidden = false
        
        let actionItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButton(_:)))
        
        let statusItem = UIBarButtonItem(title: "최신순", style: .plain, target: self, action: #selector(sortingStatus(_:)))
        
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButton(_:)))
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.setToolbarItems([actionItem, spaceItem, statusItem, spaceItem, deleteItem], animated: false)
        
    }
    
    @IBAction func selectingPhoto(_ sender: UIBarButtonItem) {
        
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
        
    }
    
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(myAlbum.count)
        
        return self.fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SecondCollectionViewCell = secondCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! SecondCollectionViewCell
        
        // asset 은 fetchResult 에서 인덱스에 해당
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: secondCollectionView.frame.width / 3, height: secondCollectionView.frame.width / 3), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            
//            cell.backgroundColor = UIColor.systemBlue
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let photoViewController: PhotoViewController = segue.destination as? PhotoViewController else { return }
        
        let cell: SecondCollectionViewCell = sender as! SecondCollectionViewCell
        
        photoViewController.seletedImage = cell.photoImage?.image

    }
    
    
}
