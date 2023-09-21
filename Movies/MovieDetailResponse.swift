//
//  MovieDetail.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import Foundation

struct MovieDetailResponse {
    let title: String
    let imageUrl: String?
    let year: String
    let genres: [Genre]
    let countries: [Country]
    let rating: Float
    let description: String
    let videos: VideoResponse
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    struct Country: Codable {
        let iso_3166_1: String
    }
      
    struct VideoResponse: Codable {
        let results: [Video]
        
        struct Video: Codable {
            let key: String
            let site: String
        }
    }
}

extension MovieDetailResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case imageUrl = "poster_path"
        case year = "release_date"
        case rating = "vote_average"
        case videos
        case description = "overview"
        case countries = "production_countries"
        case genres
    }
}
