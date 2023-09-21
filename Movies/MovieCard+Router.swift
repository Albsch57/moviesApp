//
//  MovieCard+Router.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import UIKit
import YouTubePlayerKit

final class MovieCardRouter: MovieCardViewRouting {
    
    
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    
    func presentPosterPreview(of movie: Movie) {
        let vc = DIContainer.shared.resolve(FullPosterViewInput.self, argument: movie) as! UIViewController
        viewController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func presentTrailer(from platform: VideoPlatform) {
        switch platform {
        case .youtube(let key):
            let youtubePlayer = YouTubePlayer(source: .video(id: key))
            youtubePlayer.configuration = .init(
                autoPlay: true
            )
            
            let youtubeVideoController = YouTubePlayerViewController(player: youtubePlayer)
            youtubeVideoController.view.backgroundColor = .systemBackground
            youtubeVideoController.configureWithLoader()
            
            viewController?.present(youtubeVideoController, animated: true)
        }
        
    }
}
