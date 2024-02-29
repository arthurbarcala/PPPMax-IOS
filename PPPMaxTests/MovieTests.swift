import XCTest
@testable import PPPMax

final class MovieTests: XCTestCase {
    func testFetchMoviesSuccessful() {
        let expectation = self.expectation(description: "Fetching Movies")
        let expectedMovieName = "Jack Reacher"
        
        MovieInteractor.fetchMovies(movieNameQuery: expectedMovieName){data in
            guard let data = data else {
                XCTFail("Failed to fetch data")
                return
            }
            let results = MoviePresenter.parseJSON(movieData: data)
            
            for result in results {
                if result.movieTitle.lowercased().contains(expectedMovieName.lowercased()) || result.movieDescription.lowercased().contains(expectedMovieName.lowercased()){
                    
                    expectation.fulfill()
                    break
                } else {
                    XCTFail("Expected movie not found in results.")
                }
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchMoviesFail() {
        let expectedMovieName = "AJOFEJOIA"
        
        MovieInteractor.fetchMovies(movieNameQuery: expectedMovieName){data in
            XCTAssertNil(data)
        }
    }
    
    func testMockedFetchSuccessful() {
        let expectation = self.expectation(description: "Mocking Fetch Movies")
        let expectedMovieName = "Jack Reacher"
        
        MockInteractor.fetchMovies(movieNameQuery: expectedMovieName){data in
            guard let data = data else {
                XCTFail("Failed to fetch data")
                return
            }
            let results = MoviePresenter.parseJSON(movieData: data)
            
            for result in results{
                if result.movieTitle.lowercased().contains(expectedMovieName.lowercased()) || result.movieDescription.lowercased().contains(expectedMovieName.lowercased()){
                    
                    expectation.fulfill()
                    break
                } else {
                    XCTFail("Expected movie not found in results.")
                }
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testMockedFetchFail() {
        let expectedMovieName = "AJOFEJOIA"
        
        MockInteractor.fetchMovies(movieNameQuery: expectedMovieName){data in
            XCTAssertNil(data)
        }
    }
}

