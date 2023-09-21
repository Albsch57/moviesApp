//
//  MoviesSearchViewRouter.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

final class MovieSearchViewRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        viewController.navigationItem.backButtonDisplayMode = .minimal
    }
}

extension MovieSearchViewRouter: MovieSearchViewRouting {
    
    func show(movie: Movie) {
        let vc = DIContainer.shared.resolve(MovieCardViewInput.self, argument: movie) as! UIViewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
