import Foundation

class Factory {
    func createNetworkService() -> NetworkService {
        return NetworkService()
    }
    
    func createMoviePresenter(view: ViewController) -> MoviePresenter {
        return MoviePresenter(view: view)
    }
    
    func createMovieInteractor(apiService: NetworkService, presenter: MoviePresenter) -> MovieInteractor {
        return MovieInteractor(apiService: apiService, presenter: presenter)
    }
}

