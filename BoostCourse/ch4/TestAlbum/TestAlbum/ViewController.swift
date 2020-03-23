
import UIKit
import Photos
import Foundation


class AlbumModel {
    let name: String
    let count: Int
    let collection: PHAssetCollection
    
    init(name: String, count: Int, collection: PHAssetCollection) {
        self.name = name
        self.count = count
        self.collection = collection
    }
}

var albumList: [AlbumModel] = [AlbumModel]()

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver {
    
    
    let cellIdentifier: String = "cell"
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    var allPhotos: PHFetchResult<PHAsset>!
    var smartAlbums: PHFetchResult<PHAssetCollection>!
    var userCollections: PHFetchResult<PHCollection>!
    let sectionLocalizedTitles = ["", NSLocalizedString("Smart Albums", comment: ""), NSLocalizedString("Albums", comment: "")]
    
    var scale: CGFloat!
    var targetX: CGFloat!
    var details: CGFloat!
    
    
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
        
        /*
         let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
         
         guard let cameraRollCollection = cameraRoll.firstObject else {  return }
         
         let fetchOptions = PHFetchOptions()
         fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
         
         self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
         */
        
        
        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        allPhotos = PHAsset.fetchAssets(with: fetchOptions)
        smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        
        let cameraRollAlbum = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary, options: fetchOptions)
        
        /*
        let smartAlbumFavorites = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.smartAlbumFavorites, options: fetchOptions)
        
        let smartAlbumRecentlyAdded = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.smartAlbumRecentlyAdded, options: fetchOptions)
        */
        
//  cameraRollAlbum, smartAlbumRecentlyAdded, smartAlbumFavorites, smartAlbumPanoramas, smartAlbumSelfPortraits, smartAlbumScreenshots, smartAlbumBursts
        
        [smartAlbums].forEach
            {
                $0.enumerateObjects { collection, index, stop in
                    
//                    guard let album = collection as? PHAssetCollection else { return }
                    
                    let album : PHAssetCollection = collection
                    
                    // PHAssetCollection 의 localizedTitle 을 이용해 앨범 타이틀 가져오기
                    let albumTitle : String = album.localizedTitle!
                    
                    // 이미지만 가져오도록 옵션 설정
                    let fetchOptionsForImage = PHFetchOptions()
                    fetchOptionsForImage.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                    fetchOptionsForImage.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                    
                    self.fetchResult = PHAsset.fetchAssets(in: album, options: fetchOptionsForImage)
                    
                    // PHFetchResult 의 count 을 이용해 앨범 사진 갯수 가져오기
                    let albumCount = self.fetchResult.count
                    
                    // 저장
                    let newAlbum = AlbumModel(name: albumTitle, count: albumCount, collection: album)
                    
                    print("앨범 이름 : " + newAlbum.name)
                    print("사진 수 : " + "\(newAlbum.count)" + " 개")
                    
                    //앨범 정보 추가
                    albumList.append(newAlbum)
                    
                    print("albumList : \(albumList.description)")
                    print("fetchResult : \(self.fetchResult.description)")
                }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scale = UIScreen.main.scale
        // 화면의 좁은 쪽을 기준으로 2등분한다.
        targetX = (UIScreen.main.bounds.width) * scale / 2
        
        self.collectionView?.backgroundColor = UIColor.systemYellow
        
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
    
    
    // MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("총 앨범 수 : " + "\(albumList.count)" + " 개")
        
        return albumList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
        
        for i in indexPath {
            
            // imageManager 를 통해서 request
            imageManager.requestImage(for: fetchResult.firstObject!, targetSize: CGSize(width: self.collectionView.frame.width / 2, height: self.collectionView.frame.width / 2), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
                
                cell.backgroundColor = UIColor.systemBlue
                cell.albumImage?.image = image
                cell.nameLabel?.text = albumList[i].name
                cell.countLabel?.text = (String)(albumList[i].count)
                
            }
            )}

        print("\(albumList.first!.collection)")
        
        return cell
    }
    
    
    // cell 의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        targetX = collectionView.frame.width / 2 - 2 // Min Spacing For Cell
        
        details = 48
        
//        print("Cell 크기 설정 - targetX = \(String(describing: targetX))")
        
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
        
        guard let cell: SecondCollectionViewCell = sender as? SecondCollectionViewCell else {
            return
        }
        
        nextViewController.albumTitle = albumList.first!.name
        nextViewController.albumSelected = albumList.first!.collection
        
        print("\(albumList.first!.name)")
        
//        nextViewController.photoList = albumList.first?.collection as! PHAssetCollection
        
    }
    
}
