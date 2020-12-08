//
//  MoviePosterViewController.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/12/02.
//

import UIKit

class MoviePosterViewController: UIViewController {
    
    let posterImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
