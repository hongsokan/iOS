//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/11/13.
//

import UIKit

class CommentViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var movieId: String = ""
    var movieTitle: String = ""
    var movieGrade: Int = 0
    
    let ratingView = UIView()
    let movieTitleLabel = UILabel()
    let movieGradeImage = UIImageView()
    let rateCountLabel = UILabel()
    let star1 = UIImageView()
    let star2 = UIImageView()
    let star3 = UIImageView()
    let star4 = UIImageView()
    let star5 = UIImageView()
    
    let commentView = UIView()
    let writerTextField = UITextField()
    let commentTextView = UITextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        movieTitleLabel.text = movieTitle
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        let userName = userDefaults.object(forKey: "userName")
        if userName != nil {
            writerTextField.text = userName as? String
        }
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        if writerTextField.text != "" {
            let userDefaults = UserDefaults.standard
            userDefaults.set(writerTextField.text, forKey: "userName")
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpDone(_ sender: Any) {
        if writerTextField.text!.isEmpty || commentTextView.text.isEmpty {
            let alert = UIAlertController(title: "경고", message: "닉네임 혹은 코멘트란을 채워주세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            addComments(rating: 5, writer: writerTextField.text ?? "", movie_id: movieId, contents: commentTextView.text)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        writerTextField.endEditing(true)
        commentTextView.endEditing(true)
    }
}




extension CommentViewController {
    func addViews() {
        self.view.addSubview(self.ratingView)
        ratingView.addSubview(movieTitleLabel)
        ratingView.addSubview(movieGradeImage)
        ratingView.addSubview(star1)
        ratingView.addSubview(star2)
        ratingView.addSubview(star3)
        ratingView.addSubview(star4)
        ratingView.addSubview(star5)
        ratingView.addSubview(rateCountLabel)
        self.view.addSubview(self.commentView)
        commentView.addSubview(writerTextField)
        commentView.addSubview(commentTextView)
        
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: naviBar.bottomAnchor, constant: 8).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        ratingView.heightAnchor.constraint(equalTo: ratingView.widthAnchor, multiplier: 0.5).isActive = true
        
        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 16).isActive = true
        commentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        commentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        commentView.heightAnchor.constraint(equalTo: ratingView.widthAnchor, multiplier: 1).isActive = true
        
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.topAnchor.constraint(equalTo: ratingView.topAnchor, constant: 16).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: 8).isActive = true
        movieTitleLabel.text = movieTitle
        
        movieGradeImage.translatesAutoresizingMaskIntoConstraints = false
        movieGradeImage.topAnchor.constraint(equalTo: ratingView.topAnchor, constant: 16).isActive = true
        movieGradeImage.leadingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor, constant: 8).isActive = true
        var imageName: String = ""
        switch movieGrade {
        case 12:
            imageName = "ic_12"
        case 15:
            imageName = "ic_15"
        case 19:
            imageName = "ic_19"
        default:
            imageName = "ic_allages"
        }
        movieGradeImage.image = UIImage(named: imageName)
        
        star1.translatesAutoresizingMaskIntoConstraints = false
        star2.translatesAutoresizingMaskIntoConstraints = false
        star3.translatesAutoresizingMaskIntoConstraints = false
        star4.translatesAutoresizingMaskIntoConstraints = false
        star5.translatesAutoresizingMaskIntoConstraints = false
        star1.heightAnchor.constraint(equalToConstant: 48).isActive = true
        star1.widthAnchor.constraint(equalToConstant: 48).isActive = true
        star2.heightAnchor.constraint(equalToConstant: 48).isActive = true
        star2.widthAnchor.constraint(equalToConstant: 48).isActive = true
        star3.heightAnchor.constraint(equalToConstant: 48).isActive = true
        star3.widthAnchor.constraint(equalToConstant: 48).isActive = true
        star4.heightAnchor.constraint(equalToConstant: 48).isActive = true
        star4.widthAnchor.constraint(equalToConstant: 48).isActive = true
        star5.heightAnchor.constraint(equalToConstant: 48).isActive = true
        star5.widthAnchor.constraint(equalToConstant: 48).isActive = true
        star1.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16).isActive = true
        star2.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16).isActive = true
        star3.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16).isActive = true
        star4.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16).isActive = true
        star5.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16).isActive = true
        star3.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        star2.trailingAnchor.constraint(equalTo: star3.leadingAnchor, constant: -8).isActive = true
        star4.leadingAnchor.constraint(equalTo: star3.trailingAnchor, constant: 8).isActive = true
        star1.trailingAnchor.constraint(equalTo: star2.leadingAnchor, constant: -8).isActive = true
        star5.leadingAnchor.constraint(equalTo: star4.trailingAnchor, constant: 8).isActive = true
        star1.image = UIImage(named: "ic_star_large_full")
        star2.image = UIImage(named: "ic_star_large_full")
        star3.image = UIImage(named: "ic_star_large_full")
        star4.image = UIImage(named: "ic_star_large_full")
        star5.image = UIImage(named: "ic_star_large_full")
        
        rateCountLabel.translatesAutoresizingMaskIntoConstraints = false
        rateCountLabel.topAnchor.constraint(equalTo: star1.bottomAnchor, constant: 16).isActive = true
        rateCountLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        rateCountLabel.text = "10"
        
        writerTextField.translatesAutoresizingMaskIntoConstraints = false
        writerTextField.topAnchor.constraint(equalTo: commentView.topAnchor, constant: 8).isActive = true
        writerTextField.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 8).isActive = true
        writerTextField.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: -8).isActive = true
        writerTextField.borderStyle = .roundedRect
        writerTextField.layer.borderColor = CGColor.init(gray: 100, alpha: 1)
        writerTextField.placeholder = "username"
        
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.topAnchor.constraint(equalTo: writerTextField.bottomAnchor, constant: 8).isActive = true
        commentTextView.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 8).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: -8).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: commentView.bottomAnchor, constant: -8).isActive = true
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.cornerRadius = 5
        commentTextView.layer.borderColor = UIColor.red.cgColor
        commentTextView.text = "comment"
    }
}
