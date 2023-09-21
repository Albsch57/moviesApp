//
//  Extension+UiImageView.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    fileprivate var placeholder: UIImage {
        UIImage(named: "Food")!
    }
    
    // MARK: - TheMovieDB Poster Path
    func setThumbnailPosterFromMovieDB(of movie: Movie, size: MoviesDBProvider.Poster) {
        
        let transformer = SDImageResizingTransformer(size: bounds.size.retinaSize, scaleMode:.aspectFill)
        sd_imageIndicator = SDWebImageActivityIndicator.large
        sd_imageIndicator?.indicatorView.tintColor = .red
        
        if let name = movie.posterPath {
            let url = size.url(for: name)
            sd_setImage(with: url, placeholderImage: nil, context: [.imageTransformer: transformer])
            return
        }
        
        image = placeholder
    }
}
