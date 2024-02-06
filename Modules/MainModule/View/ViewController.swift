import UIKit

class ViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    var movieName: String?
    var queryMovieName: String?
    var queryString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
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
            for movie in decodedData.results{
                print(movie.title)
                print(movie.overview)
                print("---")
            }
        } catch {
            print(error)
        }
    }
    
}

