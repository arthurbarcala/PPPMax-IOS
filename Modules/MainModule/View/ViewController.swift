import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var movieTable: UITableView!
    
    var listViewData: [MovieResult] = [
        MovieResult(movieTitle: "Olá!", movieDescription: "Tente pesquisar por um filme.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        movieTable.dataSource = self
        
        
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        MovieInteractor.fetchMovies(movieNameQuery: searchBar.text ?? ""){data in
            guard let data = data else {
                print("Failed to fetch data.")
                return
            }
            
            self.listViewData = MoviePresenter.parseJSON(movieData: data)
            
            DispatchQueue.main.async{
                self.movieTable.reloadData()
            }
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

