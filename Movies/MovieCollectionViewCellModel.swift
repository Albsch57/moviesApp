//
//  MovieCollectionViewCellModel.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit
import SDWebImage

struct MovieCollectionViewCellModel {
    let title: String
    let imageUrl: URL
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
        
        let transformer = SDImageResizingTransformer(size: cell.bounds.size, scaleMode:.aspectFill)
 
        cell.image.sd_imageIndicator = SDWebImageActivityIndicator.large
        cell.image.sd_setImage(with: imageUrl, placeholderImage: nil, context: [.imageTransformer: transformer])
      
        
        cell.genresLabel.text = genre.joined(separator: ", ")
        cell.ratingLabel.text = String(rating)
        cell.title.text = title
    }
}
