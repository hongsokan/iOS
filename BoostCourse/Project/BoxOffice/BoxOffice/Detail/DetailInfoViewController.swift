//
//  DetailInfoViewController.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/11/25.
//

/*
import UIKit

class DetailInfoViewController: UIViewController {

    var selectedMovie: MovieDetail?
    var movieId: String = ""
    var comments: [Comment] = []
    let commentIdentifier: String = "gotoComment"
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let scrollView = UIScrollView()
    
    let infoView = UIView()
    let moviePoster = UIButton()
    let titleLabel = UILabel()
    let gradeImage = UIImageView()
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    let ticketingView = UIView()
    let ticketingLabel = UILabel()
    let ticketingNumberLabel = UILabel()
    let ratingView = UIView()
    let ratingLabel = UILabel()
    let ratingNumberLabel = UILabel()
    let star1 = UIImageView()
    let star2 = UIImageView()
    let star3 = UIImageView()
    let star4 = UIImageView()
    let star5 = UIImageView()
    let audienceView = UIView()
    let audienceLabel = UILabel()
    let audienceNumberLabel = UILabel()
    
    let summaryView = UIView()
    let summaryLabel = UILabel()
    let summaryContentLabel = UILabel()
    
    let directorView = UIView()
    let directorAndCastLabel = UILabel()
    let directorLabel = UILabel()
    let directorNameLabel = UILabel()
    let castLabel = UILabel()
    let castNamesLabel = UILabel()
    
    let commentsView = UIView()
    let commentLabel = UILabel()
    let addCommentButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieInfoNotification(_:)), name: DidReceiveMovieDetailNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCommentsNotification(_:)), name: DidReceiveCommentsNotification, object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        requestMovieDetail(id: movieId)
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




extension DetailInfoViewController {
    
    @objc func touchUpPoster() {
        let popUpViewController = MoviePosterViewController()
        popUpViewController.modalPresentationStyle = .popover
        popUpViewController.posterImageView.image = moviePoster.currentImage
        present(popUpViewController, animated: true, completion: nil)
    }
    
    @objc func addComment(_ button: UIButton) {
        performSegue(withIdentifier: commentIdentifier, sender: nil)
    }
}





extension DetailInfoViewController {
    @objc func didReceiveMovieInfoNotification(_ noti: Notification) {
        guard let selectedMovie = noti.userInfo?["movie"] as? MovieDetail else { return  }
        self.selectedMovie = selectedMovie
        
        print("selectedMovie.title : \(selectedMovie.title)")
        
        OperationQueue.main.addOperation {
            self.title = selectedMovie.title
            self.addViews()
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




extension DetailInfoViewController {
    func addViews() {
        self.addScrollView()
        self.addInfoView()
        self.addSummaryView()
        self.addDirectorView()
        self.addCommentsView()
    }
    
    func addScrollView() {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 2)
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .systemGray6
        
        self.view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func addInfoView() {
        self.infoView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight / 3)
        self.scrollView.addSubview(infoView)
        
        infoView.addSubview(self.moviePoster)
        infoView.addSubview(self.titleLabel)
        infoView.addSubview(self.gradeImage)
        infoView.addSubview(self.dateLabel)
        infoView.addSubview(self.genreLabel)
        
        infoView.addSubview(self.ticketingView)
        ticketingView.addSubview(self.ticketingLabel)
        ticketingView.addSubview(self.ticketingNumberLabel)
        
        infoView.addSubview(self.ratingView)
        ratingView.addSubview(self.ratingLabel)
        ratingView.addSubview(self.ratingNumberLabel)
        ratingView.addSubview(self.star1)
        ratingView.addSubview(self.star2)
        ratingView.addSubview(self.star3)
        ratingView.addSubview(self.star4)
        ratingView.addSubview(self.star5)
        
        infoView.addSubview(self.audienceView)
        audienceView.addSubview(self.audienceLabel)
        audienceView.addSubview(self.audienceNumberLabel)
        
        
        //
        self.moviePoster.frame = CGRect(x: 8, y: 8, width: screenWidth / 4, height: 140)
        moviePoster.setImage(UIImage(named: "img_placeholder"), for: .normal)
        moviePoster.addTarget(self, action: #selector(touchUpPoster), for: .touchUpInside)
        guard let selectedMovie: MovieDetail = selectedMovie else {
            return
        }
        DispatchQueue.global().async {
            guard let imageUrl: URL = URL(string: selectedMovie.image) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.moviePoster.setImage(UIImage(data: imageData), for: .normal)
            }
        }
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: moviePoster.centerYAnchor, constant: -16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 8).isActive = true
        titleLabel.text = selectedMovie.title
        
        self.gradeImage.translatesAutoresizingMaskIntoConstraints = false
        gradeImage.topAnchor.constraint(equalTo: moviePoster.centerYAnchor, constant: -16).isActive = true
        gradeImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8).isActive = true
        var imageName: String = ""
        switch selectedMovie.grade {
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
        
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 8).isActive = true
        dateLabel.text = selectedMovie.date + " " + "개봉"
        
        self.genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 8).isActive = true
        genreLabel.text = "\(selectedMovie.genre)" + " / " + "\(selectedMovie.duration)"
        
        //
        self.ticketingView.frame = CGRect(x: 8, y: 156, width: 120, height: 120)
        self.ratingView.frame = CGRect(x: 136, y: 156, width: 120, height: 120)
        self.audienceView.frame = CGRect(x: 262, y: 156, width: 120, height: 120)
        ticketingView.backgroundColor = .white
        ratingView.backgroundColor = .white
        audienceView.backgroundColor = .white
        
        self.ticketingLabel.translatesAutoresizingMaskIntoConstraints = false
        ticketingLabel.centerXAnchor.constraint(equalTo: ticketingView.centerXAnchor).isActive = true
        ticketingLabel.centerYAnchor.constraint(equalTo: ticketingView.centerYAnchor, constant: -16).isActive = true
        ticketingLabel.text = "예매율"
        
        self.ticketingNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        ticketingNumberLabel.centerXAnchor.constraint(equalTo: ticketingView.centerXAnchor).isActive = true
        ticketingNumberLabel.centerYAnchor.constraint(equalTo: ticketingView.centerYAnchor, constant: 16).isActive = true
        ticketingNumberLabel.text = "\(selectedMovie.reservation_grade)위" + " / " + "\(selectedMovie.reservation_rate)%"
        
        //
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor, constant: -32).isActive = true
        ratingLabel.text = "평점"
        
        self.ratingNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingNumberLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        ratingNumberLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor).isActive = true
        ratingNumberLabel.text = "\(selectedMovie.user_rating)"
        
        self.star1.translatesAutoresizingMaskIntoConstraints = false
        self.star2.translatesAutoresizingMaskIntoConstraints = false
        self.star3.translatesAutoresizingMaskIntoConstraints = false
        self.star4.translatesAutoresizingMaskIntoConstraints = false
        self.star5.translatesAutoresizingMaskIntoConstraints = false
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
        star1.topAnchor.constraint(equalTo: ratingNumberLabel.bottomAnchor, constant: 8).isActive = true
        star2.topAnchor.constraint(equalTo: ratingNumberLabel.bottomAnchor, constant: 8).isActive = true
        star3.topAnchor.constraint(equalTo: ratingNumberLabel.bottomAnchor, constant: 8).isActive = true
        star4.topAnchor.constraint(equalTo: ratingNumberLabel.bottomAnchor, constant: 8).isActive = true
        star5.topAnchor.constraint(equalTo: ratingNumberLabel.bottomAnchor, constant: 8).isActive = true
        star3.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        star2.trailingAnchor.constraint(equalTo: star3.leadingAnchor, constant: -5).isActive = true
        star4.leadingAnchor.constraint(equalTo: star3.trailingAnchor, constant: 5).isActive = true
        star1.trailingAnchor.constraint(equalTo: star2.leadingAnchor, constant: -5).isActive = true
        star5.leadingAnchor.constraint(equalTo: star4.trailingAnchor, constant: 5).isActive = true
        star1.image = UIImage(named: "ic_star_large_full")
        star2.image = UIImage(named: "ic_star_large_full")
        star3.image = UIImage(named: "ic_star_large_full")
        star4.image = UIImage(named: "ic_star_large_full")
        star5.image = UIImage(named: "ic_star_large_full")
        
        let rating = selectedMovie.user_rating
        
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
        self.audienceLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceLabel.centerXAnchor.constraint(equalTo: audienceView.centerXAnchor).isActive = true
        audienceLabel.centerYAnchor.constraint(equalTo: audienceView.centerYAnchor, constant: -16).isActive = true
        audienceLabel.text = "누적관객수"
        
        self.audienceNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceNumberLabel.centerXAnchor.constraint(equalTo: audienceView.centerXAnchor).isActive = true
        audienceNumberLabel.centerYAnchor.constraint(equalTo: audienceView.centerYAnchor, constant: 16).isActive = true
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: selectedMovie.audience))
        audienceNumberLabel.text = result
    }
    
    func addSummaryView() {
        self.summaryView.frame = CGRect(x: 0, y: infoView.frame.maxY + 8, width: screenWidth, height: screenHeight / 1.5)
        // summaryView.backgroundColor = .green
        
        self.scrollView.addSubview(summaryView)
        summaryView.addSubview(summaryLabel)
        summaryView.addSubview(summaryContentLabel)
        
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 8).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 8).isActive = true
        summaryLabel.text = "줄거리"
        
        summaryContentLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryContentLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 8).isActive = true
        summaryContentLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 16).isActive = true
        summaryContentLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -8).isActive = true
        summaryContentLabel.numberOfLines = 0
        summaryContentLabel.text = selectedMovie?.synopsis
    }
    
    func addDirectorView() {
        self.directorView.frame = CGRect(x: 0, y: summaryView.frame.maxY + 8, width: screenWidth, height: screenHeight / 4)
        // directorView.backgroundColor = .yellow
        
        self.scrollView.addSubview(directorView)
        directorView.addSubview(self.directorAndCastLabel)
        directorView.addSubview(self.directorLabel)
        directorView.addSubview(self.directorNameLabel)
        directorView.addSubview(self.castLabel)
        directorView.addSubview(self.castNamesLabel)
        
        self.directorAndCastLabel.translatesAutoresizingMaskIntoConstraints = false
        directorAndCastLabel.topAnchor.constraint(equalTo: directorView.topAnchor, constant: 8).isActive = true
        directorAndCastLabel.leadingAnchor.constraint(equalTo: directorView.leadingAnchor, constant: 8).isActive = true
        directorAndCastLabel.text = "감독/출연"
        
        self.directorLabel.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.topAnchor.constraint(equalTo: directorAndCastLabel.bottomAnchor, constant: 8).isActive = true
        directorLabel.leadingAnchor.constraint(equalTo: directorView.leadingAnchor, constant: 16).isActive = true
        directorLabel.text = "감독"
        
        self.directorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        directorNameLabel.topAnchor.constraint(equalTo: directorAndCastLabel.bottomAnchor, constant: 8).isActive = true
        directorNameLabel.leadingAnchor.constraint(equalTo: directorLabel.trailingAnchor, constant: 16).isActive = true
        directorNameLabel.text = selectedMovie?.director
        
        self.castLabel.translatesAutoresizingMaskIntoConstraints = false
        castLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 8).isActive = true
        castLabel.leadingAnchor.constraint(equalTo: directorView.leadingAnchor, constant: 16).isActive = true
        castLabel.text = "출연"
        
        self.castNamesLabel.translatesAutoresizingMaskIntoConstraints = false
        castNamesLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 8).isActive = true
        castNamesLabel.leadingAnchor.constraint(equalTo: castLabel.trailingAnchor, constant: 16).isActive = true
        castNamesLabel.trailingAnchor.constraint(equalTo: directorView.trailingAnchor, constant: -8).isActive = true
        castNamesLabel.numberOfLines = 0
        castNamesLabel.text = selectedMovie?.actor
    }
    
    func addCommentsView() {
        self.commentsView.frame = CGRect(x: 0, y: directorView.frame.maxY + 8, width: screenWidth, height: screenHeight / 2)
        // commentsView.backgroundColor = .red
        
        self.scrollView.addSubview(commentsView)
        commentsView.addSubview(self.commentLabel)
        commentsView.addSubview(self.addCommentButton)
        
        self.commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.topAnchor.constraint(equalTo: commentsView.topAnchor, constant: 8).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: commentsView.leadingAnchor, constant: 8).isActive = true
        commentLabel.text = "한줄평"
        
        self.addCommentButton.translatesAutoresizingMaskIntoConstraints = false
        addCommentButton.topAnchor.constraint(equalTo: commentsView.topAnchor, constant: 8).isActive = true
        addCommentButton.trailingAnchor.constraint(equalTo: commentsView.trailingAnchor, constant: -8).isActive = true
        addCommentButton.setImage(UIImage(named: "btn_compose"), for: .normal)
        addCommentButton.addTarget(self, action: #selector(addComment(_:)), for: .touchUpInside)
        
        requestComments(id: selectedMovie?.id ?? "")
    }
    
    func displayComments(countOfComment: Int) {
        var index = 0
        
        while index < countOfComment {
            createCommentView(index)
            index += 1
        }
        
        OperationQueue.main.addOperation {
            self.commentsView.frame.size = CGSize(width: self.screenWidth, height: CGFloat(100 * countOfComment + 70))
        }
    }
    
    func createCommentView(_ index: Int) {
        
        OperationQueue.main.addOperation {
            let newCommentView: UIView = UIView(frame: CGRect(x: 0.0, y: 100.0 * Double(index) + 70.0, width: Double(self.screenWidth * 0.8), height: 100.0))
            
            self.createItemsForCommentView(newCommentView, index)
            
            self.commentsView.addSubview(newCommentView)
            
            self.scrollView.contentSize = CGSize(width: self.screenWidth, height: 100.0 * CGFloat(index) + 70.0 + self.screenHeight * 1.5 + 410)
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
    }
}

*/
