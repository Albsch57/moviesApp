//
//  FullPoster+Router.swift
//  Movies
//
//  Created by Alyona Bedrosova on 21.09.2023.
//

import Foundation
import UIKit

final class FullPosterRouter: FullPosterViewRouting {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
