//
//  PopularMoviesResponse.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

struct PopularMoviesResponse: Codable {
    let page: Int
    let results: [PopularMovie]
    let totalPages: Int
}
