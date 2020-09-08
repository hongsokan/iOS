
import UIKit
import Photos
import Foundation


class AlbumModel {
    var name: String
    var count: Int
    var collection: PHAssetCollection
    
    init(name: String, count: Int, collection: PHAssetCollection) {
        self.name = name
        self.count = count
        self.collection = collection
    }
}

var albumList: [AlbumModel] = [AlbumModel]()



class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier: String = "cell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    var fetchAssets: [PHAsset] = []
    
    var scale: CGFloat!
    var targetX: CGFloat!
    var details: CGFloat!
    
    
    /*
    // PHPhotoLibraryChangeObserver, 상태 변화 감지 메서드 추가, 바뀌었으면 테이블뷰 다시 로드
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: fetchResult)
            else {   return  }
        
        fetchResult = changes.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.collectionView?.reloadSections(IndexSet(0...0))
        }
    }
    */
    
    // iOS 에서 사진 찍으면 저장되는 카메라롤 불러오기
    // 그 결과를 fetchResult 라는 프로퍼티로 가져온다
    func requestCollection() {
        
        let fetchOptions = PHFetchOptions()
        let cameraRollAlbum = PHAssetCollection.fetchAssetCollections(with:.smartAlbum, subtype: .smartAlbumUserLibrary, options: fetchOptions)
        let smartAlbumFavorites = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: fetchOptions)
        let albumRegular = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: fetchOptions)
        
        
        [cameraRollAlbum, smartAlbumFavorites, albumRegular].forEach
            { $0.enumerateObjects { collection, index, stop in
                let album: PHAssetCollection = collection
                
                let fetchOptions2 = PHFetchOptions()
                fetchOptions2.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                
                self.fetchResult = PHAsset.fetchAssets(in: album, options: fetchOptions2)
                self.fetchAssets.append(self.fetchResult.firstObject!)
                
                let albumTitle: String = album.localizedTitle!
                let albumCount = self.fetchResult.count
                let newAlbum = AlbumModel(name: albumTitle, count: albumCount, collection: album)
                
                
                print()
                print(newAlbum.name)
                print(newAlbum.count)
                
                albumList.append(newAlbum)
                }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scale = UIScreen.main.scale
        // 화면의 좁은 쪽을 기준으로 2등분한다.
        targetX = (UIScreen.main.bounds.width) * scale / 2
        
        //        self.collectionView?.backgroundColor = UIColor.systemYellow
        
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
        
        self.navigationController?.isToolbarHidden = true
        self.navigationItem.title = "앨범"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = true
        
        OperationQueue.main.addOperation {
            self.collectionView?.reloadData()
        }
    }
    
    
    // MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("앨범 수:" + "\(albumList.count)")
        return albumList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? AlbumCollectionViewCell else { return AlbumCollectionViewCell() }

        for i in indexPath{
            
            let asset: PHAsset = self.fetchAssets[i]
            
            imageManager.requestImage(for: asset, targetSize: CGSize(width: self.collectionView.frame.width / 2, height: self.collectionView.frame.width / 2), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
                
                //                cell.backgroundColor = UIColor.systemBlue
                cell.albumImage?.image = image
                cell.nameLabel?.text = albumList[i].name
                cell.countLabel?.text = (String)(albumList[i].count)
                cell.assetCollection = albumList[i].collection
            })
        }
        
        
        return cell
    }
    
    
    // cell 의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        targetX = collectionView.frame.width / 2 - 2 // Min Spacing For Cell
        
        details = 48
        
        return CGSize(width: targetX, height: targetX + details)
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
        
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else { return }
        
        let cell: AlbumCollectionViewCell = sender as! AlbumCollectionViewCell
        
        nextViewController.fetchResult = self.fetchResult
        nextViewController.myAlbum.name = cell.nameLabel!.text!
        nextViewController.myAlbum.count = (Int)(cell.countLabel!.text!)!
        nextViewController.myAlbum.collection = cell.assetCollection
        
    }
    
}


// MARK: PHPhotoLibraryChangeObserver
extension ViewController: PHPhotoLibraryChangeObserver {
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
            self.collectionView?.reloadSections(IndexSet(0...0))
        }
    }
}
