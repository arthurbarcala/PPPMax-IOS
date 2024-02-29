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

class MockInteractor: AnyInteractor{
    static func fetchMovies(movieNameQuery: String, completion: @escaping (Data?) -> Void) {
            let mockData = """
                {"page":1,"results":[{"adult":false,"backdrop_path":"/iwvP8XVpYVmJ3xfF9xdBi5uAOWl.jpg","genre_ids":[80,18,53,28],"id":75780,"original_language":"en","original_title":"Jack Reacher","overview":"One morning in an ordinary town, five people are shot dead in a seemingly random attack. All evidence points to a single suspect: an ex-military sniper who is quickly brought into custody. The interrogation yields one written note: 'Get Jack Reacher!'. Reacher, an enigmatic ex-Army investigator, believes the authorities have the right man but agrees to help the sniper's defense attorney. However, the more Reacher delves into the case, the less clear-cut it appears. So begins an extraordinary chase for the truth, pitting Jack Reacher against an unexpected enemy, with a skill for violence and a secret to keep.","popularity":72.779,"poster_path":"/uQBbjrLVsUibWxNDGA4Czzo8lwz.jpg","release_date":"2012-12-20","title":"Jack Reacher","video":false,"vote_average":6.6,"vote_count":6689},{"adult":false,"backdrop_path":null,"genre_ids":[99],"id":1045592,"original_language":"en","original_title":"Jack Reacher: When the Man Comes Around","overview":"Cast and crew speak on adapting One Shot as the first Jack Reacher film, casting Tom Cruise, earning Lee Child's blessing, additional character qualities and the performances that shape them, Lee Child's cameo in the film, and shooting the film's climax.","popularity":14.953,"poster_path":"/tcOPca5Ook6aR9mehrnxD9kfk7m.jpg","release_date":"2013-05-07","title":"Jack Reacher: When the Man Comes Around","video":false,"vote_average":10,"vote_count":1},{"adult":false,"backdrop_path":"/ww1eIoywghjoMzRLRIcbJLuKnJH.jpg","genre_ids":[28,53],"id":343611,"original_language":"en","original_title":"Jack Reacher: Never Go Back","overview":"When Major Susan Turner is arrested for treason, ex-investigator Jack Reacher undertakes the challenging task to prove her innocence and ends up exposing a shocking conspiracy.","popularity":62.47,"poster_path":"/cOg3UT2NYWHZxp41vpxAnVCOC4M.jpg","release_date":"2016-10-19","title":"Jack Reacher: Never Go Back","video":false,"vote_average":5.97,"vote_count":4645}],"total_pages":1,"total_results":3}

            """.data(using: .utf8)
        
            if movieNameQuery.lowercased() == "jack reacher"{
                    completion(mockData)
            } else {
                completion(nil)
            }
        }
}
