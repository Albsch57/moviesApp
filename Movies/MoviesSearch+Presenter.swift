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
    private var movies = [PopularMovieViewModel]()
    
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
                didReceive(response: response)
            case .failure(let error):
                print(error)
                input?.update(viewState: .error(massage: error.localizedDescription))
            }
        }
    }

    
    func didReceive(response: PopularMoviesResponse) {
        
        // Convert to domain model
        let movies = response.results.map({
            let genres = $0.genre.compactMap({ Genre(rawValue: $0)?.title })
            return PopularMovieViewModel(id: $0.id, title: $0.title, posterPath: $0.posterURL, genre: genres, rating: $0.average)
        })
        
        
        // Stategy for pagination
        if response.page > 1 {
            self.movies += movies
        } else {
            self.movies = movies
        }
        
        // Save current state of the pagination
        currentPage = response.page
        totalPages = response.totalPages
        totalResults = response.totalResults
        
        // Update view state
        input?.update(viewState: .content())
        
        // Cache movies on background
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            cache(movies: self.movies)
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
    
    func cache(movies: [PopularMovieViewModel]) {
        try? storage?.save(object: movies, forKey: "movies")
    }
    
    func moviesFromCache() -> [PopularMovieViewModel] {
        (try? storage?.load(forKey: "movies", as: [PopularMovieViewModel].self)) ?? []
    }
}

// MARK: - MovieSearchViewOutput
extension MovieSearchPresenter: MovieSearchViewOutput {
    
    
    var numberOfItems: Int {
        movies.count
    }
    
    func item(for index: Int) -> PopularMovieViewModel {
        movies[index]
    }
    
    
    func viewDidLoad() {
        if Reachability.isConnectedToNetwork() {
            loadMovies(request: MoviesDBProvider.movies(page: currentPage, sorted: sorted))
            return
        }
        
        movies = moviesFromCache()
        input?.update(viewState: .content())
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
            input?.update(viewState: .content())
        }
    }
    
    func didTap(index: Int) {
        guard movies.indices.contains(index) else {
            input?.update(viewState: .error(massage: "Oops! Something Wrong..."))
            return
        }
        
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
    
    func refreshData() {
        loadMovies(request: MoviesDBProvider.movies(page: 1, sorted: sorted))
    }
}

