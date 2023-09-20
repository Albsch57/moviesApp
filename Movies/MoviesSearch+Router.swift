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
    }
}

extension MovieSearchViewRouter: MovieSearchViewRouting {
    func show(movie: PopularMovie) {
        //
    }
}
