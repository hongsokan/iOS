//
//  Request.swift
//  BoxOffice
//
//  Created by 안홍석 on 2020/11/16.
//

import Foundation

let DidReceiveMoviesNotification: Notification.Name = Notification.Name("DidReceiveMoviesList")
let DidReceiveMovieDetailNotification: Notification.Name = Notification.Name("DidReceiveMovieDetail")
let DidReceiveCommentsNotification: Notification.Name = Notification.Name("DidReceiveCommentsList")

// Base URL: https://connect-boxoffice.run.goorm.io/
func requestMovies(type: String) {
    
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movies?order_type=" + type) else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveMoviesNotification, object: nil, userInfo: ["movies": apiResponse.movies])
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}


func requestMovieDetail(id: String) {
    
    // connect-boxoffice.run.goorm.io/movie?id=
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movie?id=" + id) else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let apiResponse: MovieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveMovieDetailNotification, object: nil, userInfo: ["movie": apiResponse])
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}


func requestComments(id: String) {
    
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/comments?movie_id=" + id) else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let apiResponse: ResponseForComments = try JSONDecoder().decode(ResponseForComments.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveCommentsNotification, object: nil, userInfo: ["comments": apiResponse.comments])
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume()
}


// Referenced by https://developer.apple.com/documentation/foundation/url_loading_system/uploading_data_to_a_website
func addComments(rating: Int, writer: String, movie_id: String, contents: String) {
    
    struct Comment: Codable {
        let rating: Int
        let writer: String
        let movie_id: String
        let contents: String
    }
    
    let comment = Comment(rating: rating,writer: writer, movie_id: movie_id, contents: contents)
    guard let uploadData = try? JSONEncoder().encode(comment) else {
        return
    }
    
    let strUrl = "http://connect-boxoffice.run.goorm.io/comment"
    
    guard let url: URL = URL(string: strUrl) else {
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    
    let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
        if let error = error {
            print ("error: \(error)")
            return
        }
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
                print ("server error")
                return
        }
        if let mimeType = response.mimeType,
            mimeType == "application/json",
            let data = data,
            let dataString = String(data: data, encoding: .utf8) {
            print ("got data: \(dataString)")
        }
    }
    task.resume()
    
    
}
