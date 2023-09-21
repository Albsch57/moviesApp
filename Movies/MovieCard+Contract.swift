//
//  Description+Contract.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import Foundation

enum VideoPlatform {
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
    func didClose()
    func showFullPoster()
    func showTrailer(from platform: VideoPlatform)
}

// MARK: - Router
protocol MovieCardViewRouting: AnyObject {
    func dismiss()
    func presentPosterPreview()
    func presentTrailer(from platform: VideoPlatform)
}
