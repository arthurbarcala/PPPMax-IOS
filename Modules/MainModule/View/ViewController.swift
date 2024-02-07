import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var searchBar: UISearchBar!
    var movieName: String?
    var queryMovieName: String?
    var queryString: String?
    
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
        movieName = searchBar.text ?? ""
        queryMovieName = movieName?.replacingOccurrences(of: " ", with: "+")
        queryString = "https://api.themoviedb.org/3/search/movie?query=\(queryMovieName!)&api_key=f33197e7d286b19bb9d55aeecca2975f"
        
        if let url = URL(string: queryString!) {
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url){data, urlResponse, error in
                if error != nil{
                    print(error!)
                    return
                } else {
                    if let safeData = data {
                        self.parseJSON(movieData: safeData)
                    }
                }
            }
            
            task.resume()
            
        }
        
        
    }
    func parseJSON(movieData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            listViewData = []
            for movie in decodedData.results{
                listViewData.append(MovieResult(movieTitle: movie.title, movieDescription: movie.overview))
            }
            if listViewData.isEmpty {
                listViewData.append(MovieResult(movieTitle: "Nenhum filme encontrado!", movieDescription: "Tente pesquisar por outro título."))
            }
            
            DispatchQueue.main.async {
                self.movieTable.reloadData()
            }
        } catch {
            print(error)
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

