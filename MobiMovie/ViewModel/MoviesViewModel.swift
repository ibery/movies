//
//  MoviesViewModel.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//

import Foundation

struct MovieListModel {
    let movieList : [MovieModel]
    
    func numberOfRowInSection () -> Int {
        
        return self.movieList.count
    }
    
    func movieAtIndex (_ Index: Int)-> MoviesViewModel {
        let movie = self.movieList[Index]
        return MoviesViewModel(movieModel: movie)
    }
}

struct MoviesViewModel {
    let movieModel : MovieModel
    
    var title : String{
        return self.movieModel.title ?? ""
    }
    var release_date : String{
        return self.movieModel.release_date ?? ""
    }
    var overview : String{
        return self.movieModel.overview ?? ""
    }
    var backdrop_path : String{
        return self.movieModel.backdrop_path ?? ""
    }
    var id : Int {
        return self.movieModel.id ?? 0
    }
    var vote_average : Double{
        return self.movieModel.vote_average ?? 0.0
    }
}





