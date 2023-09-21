//
//  MovieCollectionViewCellModel.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

struct PopularMovieViewModel {
    let id: Int
    let title: String
    let posterPath: String?
    let genre: [String]
    let rating: Float
}

extension PopularMovieViewModel {
    func configure(_ cell: PopularMovieCollectionViewCell) {
        cell.image.setThumbnailPosterFromMovieDB(of: self, size: .w500)
        cell.genresLabel.text = genre.joined(separator: ", ")
        cell.ratingLabel.text = String(rating)
        cell.title.text = title
    }
}

extension PopularMovieViewModel: Movie {
    
}
