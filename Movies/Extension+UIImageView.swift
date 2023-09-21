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
    func setPosterFromMovieDB(of url: String?) {
        
        let transformer = SDImageResizingTransformer(size: bounds.size, scaleMode:.aspectFill)
        sd_imageIndicator = SDWebImageActivityIndicator.large
        
        if let url {
            var cdnURL = MoviesDBProvider.movies(page: 0).cdnURL
            cdnURL = cdnURL.appendingPathComponent(url)
            sd_setImage(with: cdnURL, placeholderImage: nil, context: [.imageTransformer: transformer])
            return
        }
        
        image = placeholder
    }
}
