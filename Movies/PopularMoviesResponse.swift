//
//  PopularMoviesResponse.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

struct PopularMoviesResponse {
    let page: Int
    let results: [PopularMovie]
    let totalPages: Int
    let totalResults: Int
}

extension PopularMoviesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension PopularMoviesResponse {
    struct PopularMovie: Codable {
        let id: Int
        let title: String
        let year: String
        let posterURL: String?
        let genre: [Int]
        let average: Float
        
        // MARK: - Decodable
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case year = "release_date"
            case posterURL = "poster_path"
            case genre = "genre_ids"
            case average = "vote_average"
        }
    }
    
}
