//
//  Extension+YoutubePlayer.swift
//  Movies
//
//  Created by Alyona Bedrosova on 21.09.2023.
//

import YouTubePlayerKit
import UIKit

extension YouTubePlayerViewController {
    func configureWithLoader() {
        let activityIndicator = UIActivityIndicatorView()
        
        let lastSubview = view.subviews.last
        view.insertSubview(activityIndicator, belowSubview: lastSubview!)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        activityIndicator.color = .label
        activityIndicator.startAnimating()
    }
}
