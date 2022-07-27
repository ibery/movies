
import UIKit
import Alamofire
import SwiftyJSON


class MainViewController :BaseViewController  {
    
    
    // MARK: - Properties
    var movies = [MovieModel]()
    
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=62e6bda3389eb644c71d779ebe1f18ea&language=en-US&page=1"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
  
    
    // MARK: - Setup
    
    
    // MARK: - Actions

    
    //MARK: - Methods
    
}
