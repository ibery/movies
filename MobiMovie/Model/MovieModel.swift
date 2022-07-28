//
//  MoviesModel.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//

import UIKit

struct MovieModel:Decodable {
    var title : String?
    var release_date : String?
    var overview : String?
    var backdrop_path : String?
    var id : Int?
    var vote_average : Double?
   

    
}
