//
//  DI+Assembler.swift
//  Movies
//
//  Created by Влад Третьяк on 21.09.2023.
//

import Swinject
import UIKit

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(URLBuilderType.self) { _ in
            URLBuilder()
        }
        
        container.register(NetworkClientType.self) { r in
            NetworkClient(urlBuilder: r.resolve(URLBuilderType.self)!)
        }
    }
}

final class MovieSearchAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoviesSearchViewInput.self) { r in
            MoviesSearchViewController()
        }
        .initCompleted { r, input in
            let vc = input as! MoviesSearchViewController
            vc.presenter = r.resolve(MovieSearchViewOutput.self)!
        }
        
        container.register(MovieSearchViewRouting.self) { r in
            let vc = r.resolve(MoviesSearchViewInput.self)! as! UIViewController
            return MovieSearchViewRouter(viewController: vc)
        }
        
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
        container.register(MovieCardViewInput.self) { (r, movie: Movie) in
            let vc = MovieCardViewController()
            
            let network = r.resolve(NetworkClientType.self)!
            let router = MovieCardRouter(viewController: vc)
            let presenter = MovieCardPresenter(movie: movie, router: router, networkClient: network)
            
            vc.presenter = presenter
            presenter.input = vc
            
            return vc
        }
    }
}

final class PoterPreviewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FullPosterViewInput.self) { (r, movie: Movie ) in
            let vc = FullPosterViewController()
            
            let router = FullPosterRouter(viewController: vc)
            let presenter = FullPosterPresenter(router: router, movie: movie)
            
            vc.presenter = presenter
            presenter.input = vc
            
            return vc
        }
    }
}
