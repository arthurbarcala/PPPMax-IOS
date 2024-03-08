import Foundation

protocol NetworkServicing {
    func fetchMovies(movieNameQuery: String, completion: @escaping ([MovieResult]) -> Void)
}

class NetworkService: NetworkServicing {
    func fetchMovies(movieNameQuery: String, completion: @escaping ([MovieResult]) -> Void) {
        let movieName = movieNameQuery
        let queryMovieName = movieName.replacingOccurrences(of: " ", with: "+")
        let queryString = "https://api.themoviedb.org/3/search/movie?query=\(queryMovieName)&api_key=f33197e7d286b19bb9d55aeecca2975f"
        
        guard let url = URL(string: queryString) else {
            completion([])
            return
        }

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, _, error in
            guard error == nil else {
                print("Error: \(error!)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received.")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(MovieData.self, from: data)
                var listViewData: [MovieResult] = []
                for movie in decodedData.results {
                    listViewData.append(MovieResult(movieTitle: movie.title, movieDescription: movie.overview))
                }
                if listViewData.isEmpty {
                    listViewData.append(MovieResult(movieTitle: "Nenhum filme encontrado!", movieDescription: "Tente pesquisar por outro título."))
                }
                completion(listViewData)
            } catch {
                print("Error decoding JSON: \(error)")
                completion([])
            }
        }

        task.resume()
    }
}

class MockNetworkService: NetworkServicing {
    func fetchMovies(movieNameQuery: String, completion: @escaping ([MovieResult]) -> Void) {
        if movieNameQuery == "" {
            print("No data received.")
            completion([])
            return 
        }
        
        let mockData: [MovieResult] = [
            MovieResult(movieTitle: movieNameQuery, movieDescription: movieNameQuery)
        ]
        completion(mockData)
    }
}
