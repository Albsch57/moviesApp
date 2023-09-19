//
//  MovieCollectionViewCellModel.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

struct MovieCollectionViewCellModel {
    let title: String
    let image: UIImage
    let genre: [String]
    let rating: Float
}

extension MovieCollectionViewCellModel {
    func configure(_ cell: MovieCollectionViewCell) {
        cell.image.image = image
        cell.genresLabel.text = genre.joined(separator: ", ")
        cell.ratingLabel.text = String(rating)
        cell.title.text = title
    }
}
