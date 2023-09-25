//
//  AppRouter.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

protocol AppRouterType {
    // Method to show the root screen of the application
    func showRootScreen()
}

final class AppRouter: AppRouterType {
    
    // The window used for displaying the app's interface
    private(set) var window: UIWindow
    
    // Initialize the AppRouter with a UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    // Implementing the showRootScreen method
    func showRootScreen() {
        // Resolve the root view controller from DIContainer
        let vc = DIContainer.shared.resolve(MoviesSearchViewInput.self) as! UIViewController
        
        // Set the resolved view controller as the root of a navigation controller
        window.rootViewController = UINavigationController(rootViewController: vc)
        
        // Make the window key and visible to display the root screen
        window.makeKeyAndVisible()
    }
}

