//
//  WebServices.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//

import Foundation
import Alamofire
import SwiftyJSON



class WebService {
    
    // MARK: - Properties
    static var movies = [MovieModel]()
    var movie = MovieModel()

    
    // MARK: - Initialierz
    
    
    
    // MARK: - Setup
    
    
    // MARK: - Actions
    

    //MARK: - Methods
    
    func downloadMovieData (url : String) ->[MovieModel] {
       
        AF.request(url, method: .get).validate().responseJSON {response in
            switch response.result{
                case .success(let value):
                let json = JSON(value)
                
                for index in 0...json.count{
                    let newMovies = MovieModel(title: json["results"][index]["title"].stringValue,
                                               release_date: json["results"][index]["release_date"].stringValue,
                                               overview: json["results"][index]["overview"].stringValue,
                                               backdrop_path: json["results"][index]["backdrop_path"].stringValue,
                                               id: json["results"][index]["id"].intValue,
                                               vote_average: json["results"][index]["vote_average"].doubleValue)
                    WebService.movies.append(newMovies)
                 
                    Utility.movieArray.append(newMovies)
                }
         
              
              
            case .failure(_):
                print("Error !")
            }
        }
  
        return WebService.movies
    }
    
    
    func downloadMovieDetails (url : String , movieId : Int) -> MovieModel {
        
        AF.request(url, method: .get).validate().responseJSON {response in
            switch response.result{
                case .success(let value):
                let json = JSON(value)
                
                for index in 0...json.count{
                    let newMovies = MovieModel(title: json["results"][index]["title"].stringValue,
                                               release_date: json["results"][index]["release_date"].stringValue,
                                               overview: json["results"][index]["overview"].stringValue,
                                               backdrop_path: json["results"][index]["backdrop_path"].stringValue,
                                               id: json["results"][index]["id"].intValue,
                                               vote_average: json["results"][index]["vote_average"].doubleValue)
                    
                    if newMovies.id == movieId {
                        
                        self.movie.title = newMovies.title
                        self.movie.release_date = newMovies.release_date
                        self.movie.overview = newMovies.overview
                        self.movie.backdrop_path = newMovies.backdrop_path
                        self.movie.id = newMovies.id
                        self.movie.vote_average = newMovies.vote_average
                        break
                    }
                    
                }
              
            case .failure(_):
                print("Error !")
            }
        }
        return self.movie
        
    }
    
  
}
