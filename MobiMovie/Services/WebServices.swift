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
    var c = C()
  //  var movie = MovieModel()

    
    // MARK: - Initialierz
    
    // With Alamofire
    
  
    
    
    // MARK: - Setup
    
    
    // MARK: - Actions
    

    //MARK: - Methods
    
    func downloadMovieData (url : URL , completion: @escaping ([MovieModel]?) -> () ){
        AF.request(url, method: .get).validate().responseJSON{ response in
            switch response.result{
                case.success(let value):
                
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
                            completion(self.movies)
                            case .failure(_):
                                print("Error !")
                            }
                        }
    }
   


}
    

 
