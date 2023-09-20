//
//  PopularMovie.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

struct PopularMovie {
    let id: Int
    let title: String
    let year: String
    let posterURL: String?
    let genre: [Int]
    let average: Float
}

// MARK: - Decodable
extension PopularMovie: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case year = "release_date"
        case posterURL = "poster_path"
        case genre = "genre_ids"
        case average = "vote_average"
    }
}





