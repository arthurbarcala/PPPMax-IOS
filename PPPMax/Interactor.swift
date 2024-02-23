import Foundation

protocol AnyInteractor {
    static func fetchMovies(movieNameQuery: String, completion: @escaping (Data?) -> Void)
}

class MovieInteractor: AnyInteractor {
    static func fetchMovies(movieNameQuery: String, completion: @escaping (Data?) -> Void) {
        let movieName = movieNameQuery
        let queryMovieName = movieName.replacingOccurrences(of: " ", with: "+")
        let queryString = "https://api.themoviedb.org/3/search/movie?query=\(queryMovieName)&api_key=f33197e7d286b19bb9d55aeecca2975f"

        guard let url = URL(string: queryString) else {
            completion(nil)
            return
        }

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, _, error in
            guard error == nil else {
                print("Error: \(error!)")
                completion(nil)
                return
            }

            completion(data)
        }

        task.resume()
    }

}

