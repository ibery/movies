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
    var movies = [MovieModel]()
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=62e6bda3389eb644c71d779ebe1f18ea&language=en-US&page=1"
    
    // MARK: - Initialierz
    
    
    
    // MARK: - Setup
    
    
    // MARK: - Actions
    
    func downloadMovieData () {
        
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
                    self.movies.append(newMovies)
                    
                }
            
                print(self.movies)
              
            case .failure(_):
                print("Error !")
            }
        }

        
        
    }
        
        

    
    //MARK: - Methods
    
    
  
}
