//
//  MainCollectionViewController.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/11/13.
//

import UIKit

class MainCollectionViewController: UIViewController {
    
    var movies: [Movie] = []
    var selectedMovie: Movie?
    
    let segueIdentifier: String = "gotoMovieDetail"
    
    var selectedCellIndex: Int = 0
    var cellSize: CGSize?
    let collectionCellIdentifier = "mainCollectionCell"
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "예매율순"
        self.navigationItem.setRightBarButton(.init(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(reorderMovies)), animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveMoviesNotification(_:)), name: DidReceiveMoviesNotification, object: nil)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestMovies(type: "0")
        self.navigationItem.title = "예매율순"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == self.segueIdentifier {
            guard let nextViewController = segue.destination as? DetailViewController else { return }
            
            self.navigationItem.title = "영화목록"
            nextViewController.movieId = self.selectedMovie?.id ?? ""
        }
    }

}




// MARK: CollectionView
extension MainCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.movies.count <= 0 {
            return UICollectionViewCell()
        }
        
        guard let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: self.collectionCellIdentifier, for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }
        
        let movie: Movie = self.movies[indexPath.row]
        
        guard let cellWidth = self.cellSize?.width else {
            return cell
        }
        
        cell.thumbImage.frame = CGRect(x: 8, y: 8, width: cellWidth-16, height: cellWidth+20)
        cell.thumbImage.backgroundColor = .gray
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                // cell 에서 세팅된 index와 다운로드 된 이미지의 index가 다를 수도 있다
                if let index: IndexPath = collectionView.indexPath(for: cell) {
                    if index.row == indexPath.row { // index가 같도록 처리
                        cell.thumbImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        cell.titleLabel.frame = CGRect(x: 8, y: cellWidth + 35, width: cellWidth - 10, height: 20)
        cell.titleLabel.text = movie.title
        cell.titleLabel.textAlignment = .center
        
        cell.ratingLabel.frame = CGRect(x: 8, y: cellWidth + 70, width: cellWidth - 10, height: 20)
        cell.ratingLabel.text =
            String(movie.reservation_grade) + "위" +
            "(\(String(movie.user_rating)))" + " / " +
            String(movie.reservation_rate) + "%"
        cell.ratingLabel.textAlignment = .center
        
        cell.dateLabel.frame = CGRect(x: 8, y: cellWidth + 95, width: cellWidth - 10, height: 20)
        cell.dateLabel.text = String(movie.date)
        cell.dateLabel.textAlignment = .center
        
        cell.gradeImage.frame = CGRect(x: cell.bounds.maxX - 42, y: 12, width: 30, height: 30)
        if movie.grade == 0 {
            cell.gradeImage.image = UIImage(named: "ic_allages")
        } else if (movie.grade > 0) && (movie.grade <= 12) {
            cell.gradeImage.image = UIImage(named: "ic_12")
        } else if (movie.grade > 12) && (movie.grade <= 15) {
            cell.gradeImage.image = UIImage(named: "ic_15")
        } else if (movie.grade > 15) && (movie.grade <= 19) {
            cell.gradeImage.image = UIImage(named: "ic_19")
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
        let appropriateCellWidth = (screenWidth - (screenWidth * 0.05)) / 2
        let appropriateCellHeight = appropriateCellWidth + 120
        
        cellSize = CGSize(width: appropriateCellWidth, height: appropriateCellHeight)
        
        self.cellSize = cellSize
        return cellSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = movies[indexPath.item]
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}




// MARK: Methods
extension MainCollectionViewController {
    
    @objc func didReceiveMoviesNotification(_ noti: Notification) {
        guard let movies: [Movie] = noti.userInfo?["movies"] as? [Movie] else { return }
        
        self.movies = movies
        
        // post하는 쪽에서 메인스레드 처리하였기 때문에 받는 쪽에서도 메인 스레드 처리 필요
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    @objc func reorderMovies() {
        let alert: UIAlertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        let option1: UIAlertAction = UIAlertAction(title: "예매율순", style: .default) { (UIAlertAction) in
            requestMovies(type: "0")
            // self.title = "예매율순"
            self.navigationItem.title = "예매율순"
            self.setOrderToUserDefaults("0")
        }
        let option2: UIAlertAction = UIAlertAction(title: "큐레이션순", style: .default)  { (UIAlertAction) in
            requestMovies(type: "1")
            // self.title = "큐레이션"
            self.navigationItem.title = "큐레이션순"
            self.setOrderToUserDefaults("1")
        }
        let option3: UIAlertAction = UIAlertAction(title: "개봉일순", style: .default)  { (UIAlertAction) in
            requestMovies(type: "2")
            // self.title = "개봉일순"
            self.navigationItem.title = "개봉일순"
            self.setOrderToUserDefaults("2")
        }
        let cancel: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(option1)
        alert.addAction(option2)
        alert.addAction(option3)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setOrderToUserDefaults(_ order: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(order, forKey: "order")
    }
}
