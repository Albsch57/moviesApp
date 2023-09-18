//
//  PopularMovie.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

struct PopularMovie {
    let title: String
    let year: String
    let posterURL: URL
    let genre: [Int]
    let average: Double
}

// MARK: - Decodable
extension PopularMovie: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
        case year = "release_date"
        case posterURL = "poster_path"
        case genre = "genre_ids"
        case average = "vote_average"
    }
}





