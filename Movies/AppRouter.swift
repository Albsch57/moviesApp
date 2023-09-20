//
//  AppRouter.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

protocol AppRouterType {
    func showRootScreen()
}

final class AppRouter: AppRouterType {
    
    private(set) var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showRootScreen() {
        let urlBuilder = URLBuilder()
        let networkClient = NetworkClient(urlBuilder: urlBuilder)
        
        let vc = MoviesSearchViewController()
        let router = MovieSearchViewRouter(viewController: vc)
        let presenter = MovieSearchPresenter(networkClient: networkClient, router: router)
        
        vc.presenter = presenter
        presenter.input = vc
        
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
}
