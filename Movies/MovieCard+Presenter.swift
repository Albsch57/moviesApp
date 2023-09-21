//
//  MovieCard+Presenter.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import Foundation

final class MovieCardPresenter {
    
    #warning("Надо унифицировать")
    private let movie: PopularMovie
    private let router: MovieCardRouter
    private let networkClient: NetworkClientType
   
    weak var input: MovieCardViewInput?
    
    init(movie: PopularMovie, router: MovieCardRouter, networkClient: NetworkClientType, input: MovieCardViewInput? = nil) {
        self.movie = movie
        self.router = router
        self.networkClient = networkClient
        self.input = input
    }
    
}

// MARK: - Private
private extension MovieCardPresenter {
    func loadDetails<Request: Provider>(request: Request) {
        networkClient.execute(request: request, with: MovieDetailResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.didReceive(response: response)
            case .failure(let error):
                self?.input?.update(viewState: .error(massage: error.localizedDescription))
            }
        }
    }
    
    func didReceive(response: MovieDetailResponse) {
        
        var moviewCardViewModel = MovieCardViewModel(
            title: response.title,
            imageUrl: response.imageUrl,
            genre: response.genres.map { $0.name },
            countries: response.countries.map { $0.iso_3166_1 },
            trailer: nil,
            rating: response.rating,
            description: response.description
        )
        
        if let videoMetadata = response.videos.results.first {
            moviewCardViewModel.trailer = VideoPlatform(site: videoMetadata.site, keyVideo: videoMetadata.key)
        }

         input?.update(viewState: .movie( moviewCardViewModel))
    }
}

extension MovieCardPresenter: MovieCardViewOutput {
    
    func viewDidLoad() {
        loadDetails(request: MoviesDBProvider.detailMovie(id: movie.id))
        // input?.update(viewState: .movie(movie))
    }
    
    func didClose() {
        //
    }
    
    func showFullPoster() {
        //
    }
    
    func showTrailer(from platform: VideoPlatform) {
        router.presentTrailer(from: platform)
    }
}
