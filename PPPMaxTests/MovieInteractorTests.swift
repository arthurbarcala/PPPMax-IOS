import XCTest
@testable import PPPMax

final class MovieInteractorTests: XCTestCase {
    func testInteractorSuccessful() {
        let mockedApiService = MockNetworkService()
        let mockedMoviePresenter = MockMoviePresenter(view: ViewController())
        let interactor = MovieInteractor(apiService: mockedApiService, presenter: mockedMoviePresenter)
        
        let expectedNumberOfMovies = 1
        
        interactor.fetchMovies(movieQueryName: "Testing interactor") { result in
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.count, expectedNumberOfMovies)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
    }
    
    func testInteractorFail() {
        let mockedApiService = MockNetworkService()
        let mockedMoviePresenter = MockMoviePresenter(view: ViewController())
        let interactor = MovieInteractor(apiService: mockedApiService, presenter: mockedMoviePresenter)
        
        let expectedNumberOfMovies = 0
        
        interactor.fetchMovies(movieQueryName: "") { result in
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.count, 0)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
    }
}



//presentMovies(movieData: <#T##[MovieResult]#>) { result in
//    switch result{
//    case .success([]Movie)
//    case .failure(err)
//    }
//}
