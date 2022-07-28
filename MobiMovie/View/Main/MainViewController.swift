
import UIKit
import Alamofire
import SwiftyJSON


class MainViewController :BaseViewController, UIScrollViewDelegate  {
    private var c = C()
    private var movie : MovieModel?
    private var movieListModel : MovieListModel!
   

   
    
    
    // MARK: - Properties
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var tableView: UITableView!
    
 
    
    var  movies : [ String ] = [ "American Beauty" , "Green Book" , "The Great Beauty" ,"There Will Be Blood"]
     var  frame = CGRect .zero
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

    
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        
        pageControl.numberOfPages = movies.count
        setupScreens()
        scrollView.delegate = self
        getUpComingData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
  
    
    // MARK: - Setup
    
    
    // MARK: - Actions
    

    //MARK: - Methods
    
    func setupScreens() {
        for index in 0..<movies.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: movies[index])
            
            self.scrollView.addSubview(imgView)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(movies.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func getUpComingData(){
      
        var movieList = WebService().downloadMovieData(url: c.upComing)
        
        print(movieList)
             movieListModel = MovieListModel(movieList:movieList )
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}


extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.movieListModel == nil ? 0 : self.movieListModel.numberOfRowInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell çalıştı")
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell" , for:indexPath) as! MainTableViewCell
        let movieViewModel = self.movieListModel.movieAtIndex(indexPath.row)
        
        cell.filmTitle.text = movieViewModel.title
        cell.filmOverview.text = movieViewModel.overview
        cell.filmDate.text = movieViewModel.release_date
        let url = URL(string: movieViewModel.backdrop_path)
        let data = try? Data(contentsOf: url!)
        cell.movieImage.image = UIImage(data: data!)
        cell.arrowIcon.image = UIImage(named: "Arrow Icon")

        return cell
    }


}

extension MainViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.height/20
//    }
}

