//
//  Constants.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//

import UIKit

public struct C {
    
    struct Error {
        static let title = " Warning !"
        static let overView = "Unexpected Error Occurred !"
    }

    static let api = ApiKey()
    static let imageUrl = "https://image.tmdb.org/t/p/w1280"
    static let tableViewCell = "MainTableViewCell"
    static let cellIdentifier = "mainCell"
    
    static var nowPlaying : String {
        return "https://api.themoviedb.org/3/movie/now_playing?api_key=\(api.key)&language=en-US&page=1"
    }
    
    static var upComing : String {
        return "https://api.themoviedb.org/3/movie/upcoming?api_key=\(api.key)&language=en-US&page=1"
    }
    
    static func detailsUrl(movieId : Int) -> String{
        let detailMovieUrl = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(api.key)&language=en-US"
        
        return detailMovieUrl
    }
    
    
      
}
