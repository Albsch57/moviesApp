//
//  MovieCollectionViewCellModel.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

struct MovieCollectionViewCellModel {
    let title: String
    let imageUrl: String?
    let genre: [String]
    let rating: Float
}

extension MovieCollectionViewCellModel {
    
    enum ViewState {
        case loading
        case `default`
    }
    
    func configure(_ cell: MovieCollectionViewCell) {
        //cell.image.image = imageUrl
        cell.image.setPosterFromMovieDB(of: imageUrl)
        cell.genresLabel.text = genre.joined(separator: ", ")
        cell.ratingLabel.text = String(rating)
        cell.title.text = title
    }
}
