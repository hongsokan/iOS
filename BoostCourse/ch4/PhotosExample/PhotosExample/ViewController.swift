//
//  ViewController.swift
//  PhotosExample
//
//  Created by 안홍석 on 2020/02/20.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PHPhotoLibraryChangeObserver {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    let cellIdentifier: String = "cell"
    
    @IBAction func touchUpRefreshButton(_ sender: UIBarButtonItem) {
        self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
    }
    
    // 삭제를 위한 delegate 메서드들
    
    // 어떤 로우를 편집할 수 있게 할 것인지
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 편집 모드에서 삭제 할 것인지
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult[indexPath.row]
            
            // 삭제할 것인지 Alert 화면 나오게 된다
            // 그 다음에 photoLibraryDidChange 호출된다
            PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets([asset] as NSArray)}, completionHandler: nil)
        }
    }
    
    // PHPhotoLibraryChangeObserver, 상태 변화 감지 메서드 추가, 바뀌었으면 테이블뷰 다시 로드
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {   return  }
        
        fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
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
        
        // 사용자가 사진첩 접근을 허용했는지 판단
        // 사용자의 프라이버시에 접근
        // info.plist 에서 Photo Library Usage 메시지 작성
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가")
            self.requestCollection()
            self.tableView?.reloadData()
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
                        self.tableView?.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        // asset 은 fetchResult 에서 인덱스에 해당
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        // imageManager 를 통해서 request
        // cell 에 이미지가 들어가기 때문에 작게 설정
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            cell.imageView?.image = image
        })
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: ImageZoomViewController = segue.destination as? ImageZoomViewController else { return }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else { return }
        
        guard let index: IndexPath = self.tableView.indexPath(for: cell) else { return }
        
        nextViewController.asset = self.fetchResult[index.row]
    }
    
}

