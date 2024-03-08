import Foundation

protocol MovieInteracting {
    func fetchMovies(movieQueryName: String?, completion: @escaping (Result<[MovieResult], Error>) -> Void)
}

class MovieInteractor: MovieInteracting {
    let apiService: NetworkServicing
    let presenter: MoviePresenting
    
    init(apiService: NetworkServicing, presenter: MoviePresenting) {
        self.apiService = apiService
        self.presenter = presenter
    }
    
    enum MovieError: Error {
        case invalidQuery
    }
    
    func fetchMovies(movieQueryName: String?, completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        guard let movieQueryName = movieQueryName else {
            completion(.failure(MovieError.invalidQuery))
            return
        }
        
        self.apiService.fetchMovies(movieNameQuery: movieQueryName) { data in
            self.presenter.presentMovies(movieData: data)
            completion(.success(data)) 
        }
    }
}
