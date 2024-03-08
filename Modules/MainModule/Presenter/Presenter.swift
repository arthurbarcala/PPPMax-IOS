import Foundation

protocol MoviePresenting {
    func presentMovies(movieData: [MovieResult])
}

class MoviePresenter: MoviePresenting {
    weak var view: ViewController?
    
    init(view: ViewController) {
        self.view = view
    }

    func presentMovies(movieData: [MovieResult]) {
        view?.displayMovies(movies: movieData)
    }
}

class MockMoviePresenter: MoviePresenting {
    weak var view: ViewController?
    
    init(view: ViewController) {
        self.view = view
    }
    
    func presentMovies(movieData: [MovieResult]) {
        print("Movies presented.")
    }
}







