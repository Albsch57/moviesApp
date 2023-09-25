//
//  MoviesSearchViewContract.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation

// MARK: - View
protocol MoviesSearchViewInput: AnyObject {
    func update(viewState: ViewState<Movie>)
}

// MARK: - Presenter
protocol MovieSearchViewOutput: AnyObject {
    func viewDidLoad()
    func didTapSearch(with query: String)
    func didTap(index: Int)
    func prefetchMovies()
    func changeSortState(state: SortState)
    func refreshData()
    
    var numberOfItems: Int { get }
    func item(for index: Int) -> PopularMovieViewModel
}

// MARK: - Router
protocol MovieSearchViewRouting: AnyObject {
    func show(movie: Movie)
}
