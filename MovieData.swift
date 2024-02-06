import Foundation

struct MovieData: Decodable{
    let results: [Movie]
}

struct Movie: Decodable{
//    let adult: Bool
//    let backdrop_path: String
//    let genre_ids: [Int]
//    let id: Int
//    let original_language: String
//    let original_title: String
    let overview: String
//    let popularity: Double
//    let poster_path: String
//    let release_date: Date
    let title: String
//    let video: Bool
//    let vote_average: Double
//    let vote_count: Int
}
