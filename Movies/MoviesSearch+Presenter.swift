//
//  MoviesSearchPresenter.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import Foundation
import EasyStash

final class MovieSearchPresenter {
    
    private let networkClient: NetworkClientType
    private var movies = [PopularMovie]()
    
    private var currentPage = 1
    private var totalPages = 0
    private var totalResults = 0
    
    private var storage: Storage?
    private var sorted: SortState = .descending
    
    weak var input: MoviesSearchViewInput?
    private let router: MovieSearchViewRouting
    
    init(networkClient: NetworkClientType, router: MovieSearchViewRouting) {
        self.networkClient = networkClient
        self.router = router
        makeStorage()
    }
}

// MARK: - Private Methods
private extension MovieSearchPresenter {
    func loadMovies<Request: Provider>(request: Request)  {
        networkClient.execute(request: request, with: PopularMoviesResponse.self) {  [weak self] result  in
            guard let self else { return }
            switch result {
            case .success(let response):
                if response.page > 1 {
                    movies += response.results
                } else {
                    movies = response.results
                }
                
                currentPage = response.page
                totalPages = response.totalPages
                totalResults = response.totalResults
                
                let movies = convertToMovieCollectionModel(from: response.results)
                didReceive(state: .data(rows: movies, page: currentPage))
                
            case .failure(let error):
                print(error)
                input?.update(viewState: .error(massage: error.localizedDescription))
            }
            
        }
    }

    
    func didReceive(state: ViewState<MovieCollectionViewCellModel>) {
        input?.update(viewState: state)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            cache(movies: self.movies)
        }
    }
    
    func convertToMovieCollectionModel(from items: [PopularMovie]) -> [MovieCollectionViewCellModel] {
        items.map { movie -> MovieCollectionViewCellModel  in
            let genres = movie.genre.compactMap { Genre(rawValue: $0)?.title }
            return MovieCollectionViewCellModel(title: movie.title, imageUrl: movie.posterURL, genre: genres, rating: movie.average)
        }
    }
    
    func makeStorage() {
        var options: Options = Options()
        options.folder = "MoviesApp"
        
        do {
            storage = try Storage(options: options)
        } catch {
            input?.update(viewState: .error(massage: error.localizedDescription))
        }
    }
    
    func cache(movies: [PopularMovie]) {
        try? storage?.save(object: movies, forKey: "movies")
    }
    
    func moviesFromCache() -> [PopularMovie] {
        (try? storage?.load(forKey: "movies", as: [PopularMovie].self)) ?? []
    }
}

// MARK: - MovieSearchViewOutput
extension MovieSearchPresenter: MovieSearchViewOutput {
    
    func viewDidLoad() {
        if Reachability.isConnectedToNetwork() {
            loadMovies(request: MoviesDBProvider.movies(page: currentPage, sorted: sorted))
            return
        }
        
        movies = moviesFromCache()
        input?.update(viewState: .data(rows: convertToMovieCollectionModel(from: movies), page: currentPage))
    }
    
    func didTapSearch(with query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            currentPage = 1
            loadMovies(request: MoviesDBProvider.movies(page: 1, sorted: sorted))
            return
        }
        
        if Reachability.isConnectedToNetwork() {
            loadMovies(request: MoviesDBProvider.searchMovies(query: query, page: currentPage))
        } else {
            let filteredMovies = self.movies.filter({ $0.title.localizedCaseInsensitiveContains(query) })
            let convertedMovies = convertToMovieCollectionModel(from: filteredMovies)
            input?.update(viewState: .data(rows: convertedMovies, page: currentPage))
        }
    }
    
    func didTap(index: Int) {
        router.show(movie: movies[index])
    }
    
    func prefetchMovies() {
        guard currentPage < totalPages else {
            print("Current Page \(currentPage), total Page: \(totalPages), false")
            return
        }
        
        print("Увеличили текущий page \(currentPage + 1), и загружаем данные.")
        currentPage += 1
        loadMovies(request: MoviesDBProvider.movies(page: currentPage, sorted: sorted))
    }
    
    func changeSortState(state: SortState) {
        guard Reachability.isConnectedToNetwork() else {
            input?.update(viewState: .error(massage: "Internet connection is required for sorting."))
            return
        }
        sorted = state
        currentPage = 1
        loadMovies(request: MoviesDBProvider.movies(page: currentPage, sorted: sorted))
    }
}

