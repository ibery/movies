//
//  DetailViewController.swift
//  MobiMovie
//
//  Created by Narkoz on 27.07.2022.
//


import UIKit

class DetailViewController : BaseViewController  {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var voteAverageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    
    var movieId = 0
    private var movie : MovieModel!
    private var c = C()
    private var movieListModel : MovieListModel!
    
    
    // MARK: - Properties
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("movieId  \(movieId)")
        getDetailData(url: c.detailsUrl(movieId: movieId))
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    // MARK: - Setup
    
    
    // MARK: - Actions
    
    
    //MARK: - Methods
    
        func getDetailData(url : String){
    
            let url = URL(string: url)!
    
            WebService().movieDetailData(url: url) { movieList in
                if let movieList = movieList {
                    self.movie = movieList
                    
                    DispatchQueue.main.async {
                        self.zyd()
                        
                    }
    
                }
    
            }
        }
    
    func zyd (){
       
        self.titleLabel.text = movie.title
        self.dateLabel.text = movie.release_date
        self.voteAverageLabel.text = "\(movie.vote_average) / 10"
        self.overviewLabel.text = movie.overview
        let url = URL(string: self.c.imageUrl+movie.backdrop_path!)
        let data = try? Data(contentsOf: url!)
        self.imageView.image = UIImage(data: data!)
    }
    
}

