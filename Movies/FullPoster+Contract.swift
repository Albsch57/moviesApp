//
//  FullPoster+Contract.swift
//  Movies
//
//  Created by Alyona Bedrosova on 21.09.2023.
//

import Foundation

// MARK: - View
protocol FullPosterViewInput: AnyObject {
    func update(viewState: ViewState<URL>)
}

// MARK: - Presenter
protocol FullPosterViewOutput: AnyObject {
    func viewDidLoad()
    func didClose()
}

// MARK: - Router
protocol FullPosterViewRouting: AnyObject {
    func dismiss()
}
