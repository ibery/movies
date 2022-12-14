
import UIKit
import Alamofire
import SwiftyJSON


class MainViewController :BaseViewController, UIScrollViewDelegate  {
    private var c = C()
    private var movie : MovieModel!
    private var movieListModel : MovieListModel!
    private var movieNowPlayingListModel : MovieListModel!
    var moviesName : [String] = []
    var  frame = CGRect .zero
    
    
    // MARK: - Properties
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nowComingTitleLabel: UILabel!
    
    @IBOutlet var nowComingOverviewLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getUpComingData()
        getNowPlayingdata()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: C.tableViewCell, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        scrollView.delegate = self
        pageControl.numberOfPages = moviesName.count

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Setup
    func setupScreens() {
    
        for index in 0..<moviesName.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imgView = UIImageView(frame: frame)
            imgView.isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageClick))
            let movieViewModel = movieNowPlayingListModel.movieAtIndex(index)
            nowComingTitleLabel.text = movieViewModel.title
            nowComingOverviewLabel.text = movieViewModel.overview
            let url = URL(string: C.imageUrl+movieViewModel.backdrop_path)
            
            let data = try? Data(contentsOf: url!)
            imgView.image =  UIImage(data: data!)
            imgView.addGestureRecognizer(recognizer)
            self.scrollView.addSubview(imgView)
            
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(moviesName.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
        pageControl.numberOfPages = moviesName.count
        nowComingTitleLabel.text = movieNowPlayingListModel.movieAtIndex(0).title
        nowComingOverviewLabel.text = movieNowPlayingListModel.movieAtIndex(0).overview
   
    }
    // tap gesture recognizer
    @objc func imageClick() {
        let id = movieNowPlayingListModel.movieAtIndex(Int(scrollView.contentOffset.x / scrollView.frame.size.width)).id
        guard let viewController = self.getViewController(fromStoryboard: .detail, type: DetailViewController.self) else { return }
            viewController.movieId = id
            self.navigationController?.show(viewController, sender: nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        nowComingTitleLabel.text = movieNowPlayingListModel.movieAtIndex(Int(pageNumber)).title
        nowComingOverviewLabel.text = movieNowPlayingListModel.movieAtIndex(Int(pageNumber)).overview

    }

    // MARK: - Actions
    
    
    //MARK: - Methods
     
    
    // now playing movies
    func getNowPlayingdata(){
        
        let url = URL(string: C.nowPlaying)!
        WebService().downloadMovieData(url: url) { nowPlayingMovieList in
            if let nowPlayingMovieList = nowPlayingMovieList {
                self.movieNowPlayingListModel = MovieListModel (movieList : nowPlayingMovieList )
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
        
        let url = URL(string: C.upComing)!
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier , for:indexPath) as! MainTableViewCell
        let movieViewModel = self.movieListModel.movieAtIndex(indexPath.row)
        cell.filmTitle.text = movieViewModel.title
        cell.filmOverview.text = movieViewModel.overview
        cell.filmDate.text = movieViewModel.release_date
        let url = URL(string: C.imageUrl+movieViewModel.backdrop_path)
        let data = try? Data(contentsOf: url!)
        cell.movieImage.image =  UIImage(data: data!)
        cell.arrowIcon.image = UIImage(named: "Arrow Icon")
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieid = self.movieListModel.movieAtIndex(indexPath.row)
  
        guard let viewController = self.getViewController(fromStoryboard: .detail, type: DetailViewController.self) else { return }
            viewController.movieId = movieid.id
            self.navigationController?.show(viewController, sender: nil)
    }
    
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight: CGFloat = 140.0
        return rowHeight
        //tableView.frame.height/5
    }
    
    
}

