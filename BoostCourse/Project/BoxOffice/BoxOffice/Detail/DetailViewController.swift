//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/12/02.
//


import UIKit

class DetailViewController: UIViewController {
    
    var selectedMovie: MovieDetail?
    var movieId: String = ""
    
    // 4개의 섹션으로 구성된 테이블뷰
    // 참고: https://calmone.tistory.com/entry/iOS-UIKit-in-Swift-4-section%EC%9C%BC%EB%A1%9C-%EB%82%98%EB%88%84%EC%96%B4%EC%A7%84-UITableView-%EB%A7%8C%EB%93%A4%EA%B8%B0
    // 각 섹션에서 똑같은 cell을 사용하면 dequeueReusableCell 속성 이유로 첫번째 섹션과 마지막 섹션이 겹쳐지는 현상 때문에 cellIdentifier를 각 섹션마다 다르게 사용
    // 출처: https://stackoverflow.com/questions/37938809/how-to-prevent-uitableview-from-reuse-custom-cells-swift/37938933
    
    let detailTableView = UITableView()
    let sections: [String] = ["Info", "Synopsis", "Director", "Comment"]
    let infoCellIdentifier = "infoCell"
    let synopsisCellIdentifier = "synopsisCell"
    let directorCellIdentifier = "directorCell"
    let commentsCellIdentifier = "commentsCell"
    var comments: [Comment] = []
    let commentIdentifier: String = "gotoComment"
    
    let moviePoster = UIButton()
    let titleLabel = UILabel()
    let gradeImage = UIImageView()
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    let stackView = UIStackView()
    let reservationView = UIView()
    let reservationLabel = UILabel()
    let reservationNumberLabel = UILabel()
    let userRatingView = UIView()
    let userRatingLabel = UILabel()
    let userRatingNumberLabel = UILabel()
    let audienceView = UIView()
    let audienceLabel = UILabel()
    let audienceNumberLabel = UILabel()
    let star1 = UIImageView()
    let star2 = UIImageView()
    let star3 = UIImageView()
    let star4 = UIImageView()
    let star5 = UIImageView()
    
    let synopsisLabel = UILabel()
    let synopsisContentLabel = UILabel()
    
    let directorAndCastLabel = UILabel()
    let directorLabel = UILabel()
    let directorNameLabel = UILabel()
    let castLabel = UILabel()
    let castNamesLabel = UILabel()
    
    let commentLabel = UILabel()
    let addCommentButton = UIButton()
    var commentsView = UIView()
    let commentProfileImage = UIImageView()
    let commentWriterLabel = UILabel()
    let commentTimestampLabel = UILabel()
    let commentContentLable = UILabel()
    var commentRating: Double = 0
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        self.detailTableView.register(UITableViewCell.self,
                                    forCellReuseIdentifier: infoCellIdentifier)
        self.detailTableView.register(UITableViewCell.self,
                                    forCellReuseIdentifier: synopsisCellIdentifier)
        self.detailTableView.register(UITableViewCell.self,
                                    forCellReuseIdentifier: directorCellIdentifier)
        self.detailTableView.register(UITableViewCell.self,
                                    forCellReuseIdentifier: commentsCellIdentifier)
        
        self.view.addSubview(detailTableView)
        self.detailTableView.translatesAutoresizingMaskIntoConstraints = false
        detailTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        detailTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detailTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieInfoNotification(_:)), name: DidReceiveMovieDetailNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCommentsNotification(_:)), name: DidReceiveCommentsNotification, object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        requestMovieDetail(id: movieId)
        requestComments(id: movieId)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == commentIdentifier {
            guard let nextViewController: CommentViewController = segue.destination as? CommentViewController else {
                return
            }
            
            guard let selectedMovie = selectedMovie else {
                return
            }
            
            nextViewController.movieId = selectedMovie.id
            nextViewController.movieTitle = selectedMovie.title
            nextViewController.movieGrade = selectedMovie.grade
        }
    }

}




extension DetailViewController {
    
    @objc func touchUpPoster() {
        let popUpViewController = MoviePosterViewController()
        popUpViewController.modalPresentationStyle = .popover
        popUpViewController.posterImageView.image = moviePoster.currentImage
        present(popUpViewController, animated: true, completion: nil)
    }
    
    @objc func addComment(_ button: UIButton) {
        performSegue(withIdentifier: commentIdentifier, sender: nil)
    }
    
    @objc func didReceiveMovieInfoNotification(_ noti: Notification) {
        guard let selectedMovie = noti.userInfo?["movie"] as? MovieDetail else { return  }
        self.selectedMovie = selectedMovie
        
        print("selectedMovie.title : \(selectedMovie.title)")
        
        OperationQueue.main.addOperation {
            self.title = selectedMovie.title
            self.detailTableView.reloadData()
        }
    }
    
    @objc func didReceiveCommentsNotification(_ noti: Notification) {
        guard let comments = noti.userInfo?["comments"] as? [Comment] else { return  }
        self.comments = comments
        
        print("comments.count : \(comments.count)")
        print(self.comments.count)

        if comments.count > 0 {
            displayComments(countOfComment: comments.count)
        }
    }
}





extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else if indexPath.section == 1 {
            return 600
        } else if indexPath.section == 2 {
            return 150
        } else if indexPath.section == 3 {
            return 1600
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        //
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath)
            cell.selectionStyle = .none
            cell.contentView.addSubview(self.moviePoster)
            cell.contentView.addSubview(self.titleLabel)
            cell.contentView.addSubview(self.gradeImage)
            cell.contentView.addSubview(self.dateLabel)
            cell.contentView.addSubview(self.genreLabel)
            cell.contentView.addSubview(self.stackView)
            
            //
            moviePoster.translatesAutoresizingMaskIntoConstraints = false
            moviePoster.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
            moviePoster.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8).isActive = true
            moviePoster.widthAnchor.constraint(equalToConstant: 100).isActive = true
            moviePoster.heightAnchor.constraint(equalToConstant: 140).isActive = true
            moviePoster.addTarget(self, action: #selector(touchUpPoster), for: .touchUpInside)
            moviePoster.setImage(UIImage(named: "img_placeholder"), for: .normal)
            if let selectedMovie: MovieDetail = selectedMovie {
                DispatchQueue.global().async {
                    guard let imageUrl: URL = URL(string: selectedMovie.image) else { return }
                    guard let imageData: Data = try? Data(contentsOf: imageUrl) else { return }
                    DispatchQueue.main.async {
                        self.moviePoster.setImage(UIImage(data: imageData), for: .normal)
                    }
                }
            }
            
            //
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 8).isActive = true
            titleLabel.text = selectedMovie?.title
            
            //
            gradeImage.translatesAutoresizingMaskIntoConstraints = false
            gradeImage.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
            gradeImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8).isActive = true
            var imageName: String = ""
            switch selectedMovie?.grade {
            case 12:
                imageName = "ic_12"
            case 15:
                imageName = "ic_15"
            case 19:
                imageName = "ic_19"
            default:
                imageName = "ic_allages"
            }
            gradeImage.image = UIImage(named: imageName)
            
            //
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 8).isActive = true
            dateLabel.centerYAnchor.constraint(equalTo: moviePoster.centerYAnchor).isActive = true
            dateLabel.text = selectedMovie?.date
            
            genreLabel.translatesAutoresizingMaskIntoConstraints = false
            genreLabel.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 8).isActive = true
            genreLabel.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor).isActive = true
            genreLabel.text = selectedMovie?.genre
            
            //
            // 출처: https://hcn1519.github.io/articles/2017-05/stackView
            stackView.addArrangedSubview(self.reservationView)
            stackView.addArrangedSubview(self.userRatingView)
            stackView.addArrangedSubview(self.audienceView)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 8).isActive = true
            stackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8).isActive = true
            stackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8).isActive = true
            stackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8).isActive = true
            
            //
            // reservationView.backgroundColor = .blue
            reservationView.addSubview(self.reservationLabel)
            reservationView.addSubview(self.reservationNumberLabel)
            reservationLabel.translatesAutoresizingMaskIntoConstraints = false
            reservationLabel.centerXAnchor.constraint(equalTo: reservationView.centerXAnchor).isActive = true
            reservationLabel.centerYAnchor.constraint(equalTo: reservationView.centerYAnchor, constant: -16).isActive = true
            reservationLabel.text = "예매율"
            reservationNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            reservationNumberLabel.centerXAnchor.constraint(equalTo: reservationView.centerXAnchor).isActive = true
            reservationNumberLabel.centerYAnchor.constraint(equalTo: reservationView.centerYAnchor, constant: 16).isActive = true
            reservationNumberLabel.text =
                String(selectedMovie?.reservation_grade ?? 0) + "위 / " +
                String(selectedMovie?.reservation_rate ?? 0) + "%"
            
            //
            // userRatingView.backgroundColor = .yellow
            userRatingView.addSubview(self.userRatingNumberLabel)
            userRatingView.addSubview(self.userRatingLabel)
            userRatingNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            userRatingNumberLabel.centerXAnchor.constraint(equalTo: userRatingView.centerXAnchor).isActive = true
            userRatingNumberLabel.centerYAnchor.constraint(equalTo: userRatingView.centerYAnchor).isActive = true
            userRatingNumberLabel.text = String(selectedMovie?.user_rating ?? 0)
            userRatingLabel.translatesAutoresizingMaskIntoConstraints = false
            userRatingLabel.centerXAnchor.constraint(equalTo: userRatingView.centerXAnchor).isActive = true
            userRatingLabel.bottomAnchor.constraint(equalTo: userRatingNumberLabel.topAnchor, constant: -8).isActive = true
            userRatingLabel.text = "평점"
            
            //
            userRatingView.addSubview(self.star1)
            userRatingView.addSubview(self.star2)
            userRatingView.addSubview(self.star3)
            userRatingView.addSubview(self.star4)
            userRatingView.addSubview(self.star5)
            star1.translatesAutoresizingMaskIntoConstraints = false
            star2.translatesAutoresizingMaskIntoConstraints = false
            star3.translatesAutoresizingMaskIntoConstraints = false
            star4.translatesAutoresizingMaskIntoConstraints = false
            star5.translatesAutoresizingMaskIntoConstraints = false
            star1.heightAnchor.constraint(equalToConstant: 15).isActive = true
            star1.widthAnchor.constraint(equalToConstant: 15).isActive = true
            star2.heightAnchor.constraint(equalToConstant: 15).isActive = true
            star2.widthAnchor.constraint(equalToConstant: 15).isActive = true
            star3.heightAnchor.constraint(equalToConstant: 15).isActive = true
            star3.widthAnchor.constraint(equalToConstant: 15).isActive = true
            star4.heightAnchor.constraint(equalToConstant: 15).isActive = true
            star4.widthAnchor.constraint(equalToConstant: 15).isActive = true
            star5.heightAnchor.constraint(equalToConstant: 15).isActive = true
            star5.widthAnchor.constraint(equalToConstant: 15).isActive = true
            star1.topAnchor.constraint(equalTo: userRatingNumberLabel.bottomAnchor, constant: 8).isActive = true
            star2.topAnchor.constraint(equalTo: userRatingNumberLabel.bottomAnchor, constant: 8).isActive = true
            star3.topAnchor.constraint(equalTo: userRatingNumberLabel.bottomAnchor, constant: 8).isActive = true
            star4.topAnchor.constraint(equalTo: userRatingNumberLabel.bottomAnchor, constant: 8).isActive = true
            star5.topAnchor.constraint(equalTo: userRatingNumberLabel.bottomAnchor, constant: 8).isActive = true
            star3.centerXAnchor.constraint(equalTo: userRatingView.centerXAnchor).isActive = true
            star2.trailingAnchor.constraint(equalTo: star3.leadingAnchor, constant: -5).isActive = true
            star4.leadingAnchor.constraint(equalTo: star3.trailingAnchor, constant: 5).isActive = true
            star1.trailingAnchor.constraint(equalTo: star2.leadingAnchor, constant: -5).isActive = true
            star5.leadingAnchor.constraint(equalTo: star4.trailingAnchor, constant: 5).isActive = true
            star1.image = UIImage(named: "ic_star_large_full")
            star2.image = UIImage(named: "ic_star_large_full")
            star3.image = UIImage(named: "ic_star_large_full")
            star4.image = UIImage(named: "ic_star_large_full")
            star5.image = UIImage(named: "ic_star_large_full")
            
            let rating = selectedMovie?.user_rating ?? 0
            if rating <= 2 {
                star2.image = UIImage(named: "ic_star_large")
                star3.image = UIImage(named: "ic_star_large")
                star4.image = UIImage(named: "ic_star_large")
                star5.image = UIImage(named: "ic_star_large")
                if rating < 1 {
                    star1.image = UIImage(named: "ic_star_large")
                } else {
                    star1.image = UIImage(named: "ic_star_large_half")
                }
            } else if rating <= 4 {
                star1.image = UIImage(named: "ic_star_large_full")
                star3.image = UIImage(named: "ic_star_large")
                star4.image = UIImage(named: "ic_star_large")
                star5.image = UIImage(named: "ic_star_large")
                if rating < 3 {
                    star2.image = UIImage(named: "ic_star_large")
                } else {
                    star2.image = UIImage(named: "ic_star_large_half")
                }
            } else if rating <= 6 {
                star1.image = UIImage(named: "ic_star_large_full")
                star2.image = UIImage(named: "ic_star_large_full")
                star4.image = UIImage(named: "ic_star_large")
                star5.image = UIImage(named: "ic_star_large")
                
                if rating < 5 {
                    star3.image = UIImage(named: "ic_star_large")
                } else {
                    star3.image = UIImage(named: "ic_star_large_half")
                }
            } else if rating <= 8 {
                star1.image = UIImage(named: "ic_star_large_full")
                star2.image = UIImage(named: "ic_star_large_full")
                star3.image = UIImage(named: "ic_star_large_full")
                star5.image = UIImage(named: "ic_star_large")
                if rating < 7 {
                    star4.image = UIImage(named: "ic_star_large")
                } else {
                    star4.image = UIImage(named: "ic_star_large_half")
                }
            }
            
            //
            // audienceView.backgroundColor = .orange
            audienceView.addSubview(self.audienceLabel)
            audienceView.addSubview(self.audienceNumberLabel)
            audienceLabel.translatesAutoresizingMaskIntoConstraints = false
            audienceLabel.centerXAnchor.constraint(equalTo: audienceView.centerXAnchor).isActive = true
            audienceLabel.centerYAnchor.constraint(equalTo: audienceView.centerYAnchor, constant: -16).isActive = true
            audienceLabel.text = "누적관객수"
            audienceNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            audienceNumberLabel.centerXAnchor.constraint(equalTo: audienceView.centerXAnchor).isActive = true
            audienceNumberLabel.centerYAnchor.constraint(equalTo: audienceView.centerYAnchor, constant: 16).isActive = true
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: selectedMovie?.audience ?? 0))
            audienceNumberLabel.text = result
        }
        
        //
        else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: synopsisCellIdentifier, for: indexPath)
            cell.selectionStyle = .none
            cell.contentView.addSubview(self.synopsisLabel)
            cell.contentView.addSubview(self.synopsisContentLabel)
            
            //
            synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
            synopsisLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
            synopsisLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8).isActive = true
            synopsisLabel.text = "줄거리"
            synopsisContentLabel.translatesAutoresizingMaskIntoConstraints = false
            synopsisContentLabel.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 8).isActive = true
            synopsisContentLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16).isActive = true
            synopsisContentLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8).isActive = true
            synopsisContentLabel.numberOfLines = 0
            synopsisContentLabel.text = selectedMovie?.synopsis
        }
        
        //
        else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: directorCellIdentifier, for: indexPath)
            cell.selectionStyle = .none
            cell.contentView.addSubview(self.directorAndCastLabel)
            cell.contentView.addSubview(self.directorLabel)
            cell.contentView.addSubview(self.directorNameLabel)
            cell.contentView.addSubview(self.castLabel)
            cell.contentView.addSubview(self.castNamesLabel)
            directorAndCastLabel.translatesAutoresizingMaskIntoConstraints = false
            directorAndCastLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
            directorAndCastLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8).isActive = true
            directorAndCastLabel.text = "감독/출연"
            directorLabel.translatesAutoresizingMaskIntoConstraints = false
            directorLabel.topAnchor.constraint(equalTo: directorAndCastLabel.bottomAnchor, constant: 8).isActive = true
            directorLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16).isActive = true
            directorLabel.text = "감독"
            directorNameLabel.translatesAutoresizingMaskIntoConstraints = false
            directorNameLabel.topAnchor.constraint(equalTo: directorAndCastLabel.bottomAnchor, constant: 8).isActive = true
            directorNameLabel.leadingAnchor.constraint(equalTo: directorLabel.trailingAnchor, constant: 16).isActive = true
            directorNameLabel.text = selectedMovie?.director
            castLabel.translatesAutoresizingMaskIntoConstraints = false
            castLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 8).isActive = true
            castLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16).isActive = true
            castLabel.text = "출연"
            castNamesLabel.translatesAutoresizingMaskIntoConstraints = false
            castNamesLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 8).isActive = true
            castNamesLabel.leadingAnchor.constraint(equalTo: castLabel.trailingAnchor, constant: 16).isActive = true
            castNamesLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8).isActive = true
            castNamesLabel.numberOfLines = 0
            castNamesLabel.text = selectedMovie?.actor
        }
        
        //
        else if indexPath.section == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: commentsCellIdentifier, for: indexPath)
            cell.selectionStyle = .none
            cell.contentView.addSubview(self.commentLabel)
            cell.contentView.addSubview(self.addCommentButton)
            cell.contentView.addSubview(self.commentsView)
            commentLabel.translatesAutoresizingMaskIntoConstraints = false
            commentLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
            commentLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8).isActive = true
            commentLabel.text = "한줄평"
            addCommentButton.translatesAutoresizingMaskIntoConstraints = false
            addCommentButton.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8).isActive = true
            addCommentButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8).isActive = true
            addCommentButton.setImage(UIImage(named: "btn_compose"), for: .normal)
            addCommentButton.addTarget(self, action: #selector(addComment(_:)), for: .touchUpInside)
        }
        
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}




extension DetailViewController {
    func displayComments(countOfComment: Int) {
        var index = 0
        
        while index < countOfComment {
            createCommentView(index)
            index += 1
        }
        
        OperationQueue.main.addOperation {
            self.commentsView = UIView(frame: CGRect(x: 0, y: 50, width: self.screenWidth, height: CGFloat(100 * countOfComment + 70)))
            // self.commentsView.backgroundColor = .gray
            // self.commentsView.frame.size = CGSize(width: self.screenWidth, height: CGFloat(100 * countOfComment + 70))
        }
    }
    
    func createCommentView(_ index: Int) {
        
        OperationQueue.main.addOperation {
            let newCommentView: UIView = UIView(frame: CGRect(x: 0.0, y: 100.0 * Double(index) + 70.0, width: Double(self.screenWidth * 0.8), height: 100.0))
            
            self.createItemsForCommentView(newCommentView, index)
            self.commentsView.addSubview(newCommentView)
        }
    }
    
    func createItemsForCommentView(_ view: UIView, _ index: Int) {
        let profileImage: UIImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 65, height: 65))
        let rateImage: UIImageView = UIImageView(frame: CGRect(x: screenWidth * 0.3 + 20, y: 10, width: 20, height: 20))
        let name: UILabel = UILabel(frame: CGRect(x: 95, y: 10, width: screenWidth * 0.3, height: 20))
        let dateAndTime: UILabel = UILabel(frame: CGRect(x: 95, y: 40, width: screenWidth * 0.5, height: 20))
        let content: UILabel = UILabel(frame: CGRect(x: 95, y: 70, width: screenWidth * 0.7, height: 20))
        
        profileImage.image = UIImage(named: "ic_user_loading")
        name.text = comments[index].writer
        content.text = comments[index].contents
        
        // Referenced by https://stackoverflow.com/questions/40648284/converting-a-unix-timestamp-into-date-as-string-swift
        let unixTimeInterval = comments[index].timestamp
        let date = Date(timeIntervalSince1970: unixTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        // dateFormatter.locale = NSLocale.current
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strDate = dateFormatter.string(from: date)
        dateAndTime.text = strDate
        
//        let rate: Double = comments[index].rating
        
        view.addSubview(profileImage)
        view.addSubview(rateImage)
        view.addSubview(name)
        view.addSubview(dateAndTime)
        view.addSubview(content)
        
//        commentProfileImage.image = UIImage(named: "ic_user_loading")
//        commentWriterLabel.text = comments[index].writer
//        commentContentLable.text = comments[index].contents
//        commentTimestampLabel.text = String(comments[index].timestamp)
    }
}

