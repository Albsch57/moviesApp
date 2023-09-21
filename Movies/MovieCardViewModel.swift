//
//  MovieCardViewModel.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import Foundation

struct MovieCardViewModel {
    let id: Int
    let title: String
    let posterPath: String?
    let genre: [String]
    let countries: [String]
    var trailer: VideoPlatform?
    let rating: Float
    let description: String
}

extension MovieCardViewModel: Movie {
    
}
