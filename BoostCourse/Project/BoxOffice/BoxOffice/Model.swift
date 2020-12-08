//
//  Model.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/11/16.
//

import Foundation

struct APIResponse: Codable {
    let movies: [Movie]
    // let movieDetail: MovieDetail
}

struct Movie: Codable {
    let grade: Int
    let thumb: String
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String
}

struct MovieDetail: Codable {
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let grade: Int
    let image: String
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String
}


struct ResponseForComments: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movie_id: String
    let contents: String
}
