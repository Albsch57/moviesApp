//
//  DI+Assembler.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Swinject
import UIKit

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        // Register URLBuilderType implementation
        container.register(URLBuilderType.self) { _ in
            URLBuilder()
        }
        
        // Register NetworkClientType implementation with URLBuilder dependency
        container.register(NetworkClientType.self) { r in
            NetworkClient(urlBuilder: r.resolve(URLBuilderType.self)!)
        }
    }
}


final class MovieSearchAssembly: Assembly {
    func assemble(container: Container) {
        // Register MoviesSearchViewInput implementation
        container.register(MoviesSearchViewInput.self) { r in
            MoviesSearchViewController()
        }
        .initCompleted { r, input in
            // Initialize MoviesSearchViewController's presenter with MovieSearchViewOutput
            let vc = input as! MoviesSearchViewController
            vc.presenter = r.resolve(MovieSearchViewOutput.self)!
        }
        
        // Register MovieSearchViewRouting implementation
        container.register(MovieSearchViewRouting.self) { r in
            let vc = r.resolve(MoviesSearchViewInput.self)! as! UIViewController
            return MovieSearchViewRouter(viewController: vc)
        }
        
        // Register MovieSearchViewOutput implementation with dependencies
        container.register(MovieSearchViewOutput.self) { r in
            let network = r.resolve(NetworkClientType.self)!
            let router = r.resolve(MovieSearchViewRouting.self)!
            let presenter = MovieSearchPresenter(networkClient: network, router: router)
            presenter.input = r.resolve(MoviesSearchViewInput.self)!
            return presenter
        }
    }
}



final class MovieCardAssembly: Assembly {
    func assemble(container: Container) {
        // Register MovieCardViewInput implementation with movie dependency
        container.register(MovieCardViewInput.self) { (r, movie: Movie) in
            let vc = MovieCardViewController()
            
            // Initialize MovieCardPresenter with dependencies
            let network = r.resolve(NetworkClientType.self)!
            let router = MovieCardRouter(viewController: vc)
            let presenter = MovieCardPresenter(movie: movie, router: router, networkClient: network)
            
            // Set presenter and input for the view controller
            vc.presenter = presenter
            presenter.input = vc
            
            return vc
        }
    }
}


final class PoterPreviewAssembly: Assembly {
    func assemble(container: Container) {
        // Register FullPosterViewInput implementation with movie dependency
        container.register(FullPosterViewInput.self) { (r, movie: Movie) in
            let vc = FullPosterViewController()
            
            // Initialize FullPosterPresenter with dependencies
            let router = FullPosterRouter(viewController: vc)
            let presenter = FullPosterPresenter(router: router, movie: movie)
            
            // Set presenter and input for the view controller
            vc.presenter = presenter
            presenter.input = vc
            
            return vc
        }
    }
}
