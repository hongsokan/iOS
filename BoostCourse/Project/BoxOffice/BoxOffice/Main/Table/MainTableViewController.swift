//
//  ViewController.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/11/12.
//

import UIKit

class MainTableViewController: UIViewController {
    
    var movies: [Movie] = []
    var selectedMovie: Movie?
    
    let segueIdentifier: String = "gotoMovieDetail"
    
    let tableCellIdentifier = "mainTableCell"
    @IBOutlet weak var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "예매율순"
        self.tabBarController?.tabBar.items?.first?.image = UIImage(named: "ic_table")
        self.tabBarController?.tabBar.items?.last?.image = UIImage(named: "ic_collection")
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
extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: self.tableCellIdentifier, for: indexPath) as? MainTableViewCell
        else { return UITableViewCell() }
        // let cellWidth = cell.bounds.width
        // let cellHeight = cell.bounds.height
        
        let movie: Movie = self.movies[indexPath.row]
        
        cell.thumbImage.translatesAutoresizingMaskIntoConstraints = false
        cell.thumbImage.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8).isActive = true
        cell.thumbImage.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
        cell.thumbImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cell.thumbImage.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.thumbImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        cell.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.titleLabel.leadingAnchor.constraint(equalTo: cell.thumbImage.trailingAnchor, constant: 8).isActive = true
        cell.titleLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
        cell.titleLabel.text = movie.title
        cell.titleLabel.font = UIFont.systemFont(ofSize: 22)
        
        cell.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.ratingLabel.leadingAnchor.constraint(equalTo: cell.thumbImage.trailingAnchor, constant: 8).isActive = true
        cell.ratingLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        cell.ratingLabel.text =
            "평점: " + String(movie.user_rating) + "/ " +
            "예매순위: " +  String(movie.reservation_grade) + "/ " +
            "예매율: " + String(movie.reservation_rate)
        cell.ratingLabel.font = UIFont.systemFont(ofSize: 18)
        
        cell.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.dateLabel.leadingAnchor.constraint(equalTo: cell.thumbImage.trailingAnchor, constant: 8).isActive = true
        cell.dateLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8).isActive = true
        cell.dateLabel.text = "개봉일: " + String(movie.date)
        cell.dateLabel.font = UIFont.systemFont(ofSize: 18)
        
        cell.gradeImage.translatesAutoresizingMaskIntoConstraints = false
        cell.gradeImage.centerYAnchor.constraint(equalTo: cell.titleLabel.centerYAnchor).isActive = true
        cell.gradeImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8).isActive = true
        
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = movies[indexPath.item]
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}





// MARK: Methods
extension MainTableViewController {
    
    @objc func didReceiveMoviesNotification(_ noti: Notification) {
        guard let movies: [Movie] = noti.userInfo?["movies"] as? [Movie] else { return }
        
        self.movies = movies
        
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
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
