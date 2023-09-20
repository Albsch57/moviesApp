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
