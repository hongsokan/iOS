//
//  ViewController.swift
//  MyAlbum
//
//  Created by 안홍석 on 2020/02/22.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver {
    
    let cellIdentifier: String = "cell"
    var myalbums: [MyAlbum] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    var fetchCollection: PHFetchResult<PHAssetCollection>!

    var scale: CGFloat!
    var targetX: CGFloat!
    var albumDetailsSpace: CGFloat! = 48
    
    
    
    // PHPhotoLibraryChangeObserver, 상태 변화 감지 메서드 추가, 바뀌었으면 테이블뷰 다시 로드
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {   return  }
        
        fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.collectionView?.reloadSections(IndexSet(0...0))
        }
    }
    
    // iOS 에서 사진 찍으면 저장되는 카메라롤 불러오기
    // 콜렉션에 있는 사진들 가져와
    // 최신순 정렬
    // 그 결과를 fetchResult 라는 프로퍼티로 가져온다
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else {  return }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scale = UIScreen.main.scale
        // 화면의 좁은 쪽을 기준으로 2등분한다.
        targetX = (UIScreen.main.bounds.width) * scale / 2
        
        collectionView.backgroundColor = UIColor.systemYellow
        
        // 사용자가 사진첩 접근을 허용했는지 판단
        // 사용자의 프라이버시에 접근
        // info.plist 에서 Photo Library Usage 메시지 작성
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가")
            self.requestCollection()
            self.collectionView?.reloadData()
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
                        self.collectionView?.reloadData()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "앨범"

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! AlbumCollectionViewCell

        // asset 은 fetchResult 에서 인덱스에 해당
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        
        // imageManager 를 통해서 request
        imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            
            cell.backgroundColor = UIColor.systemBlue
            
            cell.imageView.image = image
            cell.nameLabel.text = "앨범"
            cell.countLabel.text = (String)(self.fetchResult.count)
            
//            cell.imageView.translatesAutoresizingMaskIntoConstraints = false
//            cell.imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
//            cell.imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
//            cell.imageView.leadingAnchor.constraint(equalTo: cell.).isActive = true
//            cell.imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
//            cell.imageView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
//            cell.imageView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: cell.bottomAnchor, multiplier: 0.8).isActive = true
//            cell.imageView.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.5).isActive = true
//            cell.imageView.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 0.5).isActive = true
            
//            cell.nameLabel.translatesAutoresizingMaskIntoConstraints = false
//            cell.nameLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            
//            cell.countLabel.translatesAutoresizingMaskIntoConstraints = false
//            cell.countLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
//            cell.countLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        })
        
        return cell
    }


    // cell 의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        targetX = collectionView.frame.width / 2 - 8 // Min Spacing For Cell

        print("Cell 크기 설정 - targetX = \(String(describing: targetX))")

        return CGSize(width: targetX, height: targetX + albumDetailsSpace)
    }
    
    // cell 간의 가로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8 as CGFloat
    }
    
    // cell 간의 세로 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16 as CGFloat
    }
    

}


class CollectionViewLayout: UICollectionViewLayout {
    
    override func prepare() {
  
    }
}
