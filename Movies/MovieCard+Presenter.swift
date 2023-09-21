//
//  MovieCard+Presenter.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import Foundation

final class MovieCardPresenter {
    
    private let movie: Movie
    private let router: MovieCardViewRouting
    private let networkClient: NetworkClientType
   
    weak var input: MovieCardViewInput?
    
    init(movie: Movie, router: MovieCardViewRouting, networkClient: NetworkClientType, input: MovieCardViewInput? = nil) {
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
        
        var movieCardViewModel = MovieCardViewModel(
            id: response.id,
            title: response.title,
            posterPath: response.imageUrl,
            genre: response.genres.map { $0.name },
            countries: response.countries.map { $0.iso_3166_1 },
            trailer: nil,
            rating: response.rating,
            description: response.description
        )
        
        if let videoMetadata = response.videos.results.first {
            movieCardViewModel.trailer = VideoPlatform(site: videoMetadata.site, keyVideo: videoMetadata.key)
        }

        input?.update(viewState: .content(movieCardViewModel))
    }
}

extension MovieCardPresenter: MovieCardViewOutput {
    
    func viewDidLoad() {
        loadDetails(request: MoviesDBProvider.detailMovie(id: movie.id))
    }
    
    func showFullPoster(from movie: Movie) {
        router.presentPosterPreview(of: movie)
    }
    
    func showTrailer(from platform: VideoPlatform) {
        router.presentTrailer(from: platform)
    }
}
