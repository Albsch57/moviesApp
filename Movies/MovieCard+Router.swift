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
    
    func dismiss() {
        //
    }
    
    func presentPosterPreview(of poster: String) {
        let vc = FullPosterViewController()
        let router = FullPosterRouter(viewController: vc)
        let presenter = FullPosterPresenter(router: router, poster: poster)
        
        presenter.input = vc
        vc.presenter = presenter
        
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
            youtubeVideoController.view.backgroundColor = .black
            youtubeVideoController.configureWithLoader()
            
            viewController?.present(youtubeVideoController, animated: true)
        }
        
    }
}
