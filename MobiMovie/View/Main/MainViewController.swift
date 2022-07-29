
import UIKit
import Alamofire
import SwiftyJSON


class MainViewController :BaseViewController, UIScrollViewDelegate  {
    private var c = C()
    private var movie : MovieModel!
    private var movieListModel : MovieListModel!
    private var movieNowPlayingListModel : MovieListModel!
    var moviesName : [String] = []
    
    
    
    // MARK: - Properties
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var tableView: UITableView!

    var  frame = CGRect .zero
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //        let storyboard = UIStoryboard(name: "DetailScreen" , bundle: nil)
        //        guard let viewController = storyboard.instantiateInitialViewController() else { return }
        //        self.navigationController?.show(viewController, sender: nil)
        
        getUpComingData()
        getNowPlayingdata()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        
        pageControl.numberOfPages = moviesName.count
        //  setupScreens()
        scrollView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    // MARK: - Setup
    func setupScreens() {
        for index in 0..<moviesName.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let  imgView = UIImageView(frame: frame)
            imgView.isUserInteractionEnabled = true
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageClick))
            let movieViewModel = movieNowPlayingListModel.movieAtIndex(index)
 
            let url = URL(string: self.c.imageUrl+movieViewModel.backdrop_path)
            let data = try? Data(contentsOf: url!)
            imgView.image =  UIImage(data: data!)
            imgView.addGestureRecognizer(recognizer)
            
            
            
            self.scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(moviesName.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    // tap gesture recognizer
    @objc func imageClick() {
        print(movieNowPlayingListModel.movieAtIndex(Int(scrollView.contentOffset.x / scrollView.frame.size.width)).id)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        
    }
    
    
    // MARK: - Actions
    
    
    //MARK: - Methods
    
    
    
    // now playing movies
    func getNowPlayingdata(){
        
        let url = URL(string: c.nowPlaying)!
        WebService().downloadMovieData(url: url) { nowPlayingMovieList in
            if let nowPlayingMovieList = nowPlayingMovieList {
                self.movieNowPlayingListModel = MovieListModel (movieList : nowPlayingMovieList )
                
            }
            
            if let nowPlayingMovieList = nowPlayingMovieList {
                for mv in nowPlayingMovieList{
                    self.moviesName.append(mv.backdrop_path ?? "")
                    
                    
                }
                
                DispatchQueue.main.async {
                    self.setupScreens()
                }

            }
            
        }
        
    }
    
    
    // up coming movies
    func getUpComingData(){
        
        let url = URL(string: c.upComing)!
        
        WebService().downloadMovieData(url: url) { movieList in
            if let movieList = movieList {
                self.movieListModel = MovieListModel(movieList: movieList)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // details movie
    
    func getDetailData(url : String){
        
        let url = URL(string: url)!
        
        WebService().downloadMovieData(url: url) { movieList in
            if let movieList = movieList {
                self.movieListModel = MovieListModel(movieList: movieList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}


extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.movieListModel == nil ? 0 : self.movieListModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell" , for:indexPath) as! MainTableViewCell
        let movieViewModel = self.movieListModel.movieAtIndex(indexPath.row)
        
        cell.filmTitle.text = movieViewModel.title
        cell.filmOverview.text = movieViewModel.overview
        cell.filmDate.text = movieViewModel.release_date
        let url = URL(string: c.imageUrl+movieViewModel.backdrop_path)
        let data = try? Data(contentsOf: url!)
        cell.movieImage.image =  UIImage(data: data!)
        cell.arrowIcon.image = UIImage(named: "Arrow Icon")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = self.movieListModel.movieAtIndex(indexPath.row)
        print("movie id \(movieId.id)")
        
        
        
        

        
        
    }
    
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5
    }
    
    
}

