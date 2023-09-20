//
//  MoviesSearchViewContract.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

// объявлены все требования протокола для вью, презентера и контракта


// MARK: - View
protocol MoviesSearchViewInput: AnyObject {
    func update(viewState: ViewState<MovieCollectionViewCellModel>)
}

// MARK: - Presenter
protocol MovieSearchViewOutput: AnyObject {
    func viewDidLoad()
    func didTapSearch(with query: String)
    func didTap(index: Int)
    func prefetchMovies()
    func changeSortState(state: SortState)
}

// MARK: - Router
protocol MovieSearchViewRouting: AnyObject {
    func show(movie: PopularMovie)
}
