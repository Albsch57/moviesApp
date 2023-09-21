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
        let vc = DIContainer.shared.resolve(MoviesSearchViewInput.self) as! UIViewController
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }
}
