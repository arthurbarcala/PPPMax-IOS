import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTable: UITableView!
    var interactor: MovieInteractor!
    
    var listViewData: [MovieResult] = [
            MovieResult(movieTitle: "Olá!", movieDescription: "Tente pesquisar por um filme.")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        movieTable.dataSource = self
        
        let factory = Factory()
        
        let apiService = factory.createNetworkService()
        let presenter = factory.createMoviePresenter(view: self)
        self.interactor = factory.createMovieInteractor(apiService: apiService, presenter: presenter)
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        interactor.fetchMovies(movieQueryName: searchBar.text) { data in
        }
    }
    
    func displayMovies(movies: [MovieResult]) {
        self.listViewData = movies
        
        DispatchQueue.main.async {
            self.movieTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listViewData[indexPath.row]
        let cell = movieTable.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as! MovieListCell
        
        cell.movieTitle.text = item.movieTitle
        cell.movieDescription.text = item.movieDescription
        return cell
    }
}
