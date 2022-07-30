//
//  Constants.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//

import UIKit

public struct C {

    let api = ApiKey()
    let imageUrl = "https://image.tmdb.org/t/p/w1280"
    let tableViewCell = "MainTableViewCell"
    let cellIdentifier = "mainCell"
    
    var nowPlaying : String {
        return "https://api.themoviedb.org/3/movie/now_playing?api_key=\(api.key)&language=en-US&page=1"
    }
    
    var upComing : String {
        return "https://api.themoviedb.org/3/movie/upcoming?api_key=\(api.key)&language=en-US&page=1"
    }
    
    func detailsUrl(movieId : Int) -> String{
        let detailMovieUrl = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(api.key)&language=en-US"
        
        return detailMovieUrl
    }
      
}
