//
//  FullPoster+Presenter.swift
//  Movies
//
//  Created by Alyona Bedrosova on 21.09.2023.
//

import Foundation

final class FullPosterPresenter {
    
    weak var input: FullPosterViewInput?
    let router: FullPosterViewRouting
    let movie: Movie
    
    init(input: FullPosterViewInput? = nil, router: FullPosterViewRouting, movie: Movie) {
        self.input = input
        self.router = router
        self.movie = movie
    }
}

extension FullPosterPresenter: FullPosterViewOutput {
    func viewDidLoad() {
        guard let posterPath = movie.posterPath else {
            input?.update(viewState: .error(massage: "Oops. Something wrong..."))
            return
        }
        
        let originalURL = MoviesDBProvider.Poster.original.url(for: posterPath)
        input?.update(viewState: .content(originalURL))
    }
    
    func didClose() {
        router.dismiss()
    }
}
