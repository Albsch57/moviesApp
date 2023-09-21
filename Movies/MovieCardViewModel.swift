//
//  MovieCardViewModel.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import Foundation

struct MovieCardViewModel {
    let title: String
    let imageUrl: String?
    let genre: [String]
    let countries: [String]
    var trailer: VideoPlatform?
    let rating: Float
    let description: String
}
