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
        let vc = MovieCardViewController()
        let router = MovieCardRouter(viewController: vc)
        let presenter = MovieCardPresenter(movie: movie, router: router, networkClient: NetworkClient(urlBuilder: URLBuilder()))
        
        vc.presenter = presenter
        presenter.input = vc
        
        viewController?.present(vc, animated: true)
    }
}
