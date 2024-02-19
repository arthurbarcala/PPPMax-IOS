import Foundation

protocol AnyPresenter {
    static func parseJSON(movieData: Data) -> [MovieResult]
}

class MoviePresenter: AnyPresenter{
    static func parseJSON(movieData: Data) -> [MovieResult]{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            var listViewData: [MovieResult] = []
            for movie in decodedData.results{
                listViewData.append(MovieResult(movieTitle: movie.title, movieDescription: movie.overview))
            }
            if listViewData.isEmpty {
                listViewData.append(MovieResult(movieTitle: "Nenhum filme encontrado!", movieDescription: "Tente pesquisar por outro título."))
            }
            
            return listViewData
        } catch {
            print(error)
        }
        return []
    }
}
