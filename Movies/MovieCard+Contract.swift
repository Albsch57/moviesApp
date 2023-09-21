//
//  Description+Contract.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import Foundation

enum VideoPlatform: Codable {
    case youtube(key: String)
    
    init?(site: String, keyVideo: String) {
        switch site {
        case "YouTube":
            self = .youtube(key: keyVideo)
        default:
            return nil
        }
    }
}

// MARK: - View
protocol MovieCardViewInput: AnyObject {
    func update(viewState: ViewState<MovieCardViewModel>)
}

// MARK: - Presenter
protocol MovieCardViewOutput: AnyObject {
    func viewDidLoad()
    func showFullPoster(from movie: Movie)
    func showTrailer(from platform: VideoPlatform)
}

// MARK: - Router
protocol MovieCardViewRouting: AnyObject {
    func presentPosterPreview(of movie: Movie)
    func presentTrailer(from platform: VideoPlatform)
}
