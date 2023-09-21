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
    let poster: String
    
    init(input: FullPosterViewInput? = nil, router: FullPosterViewRouting, poster: String) {
        self.input = input
        self.router = router
        self.poster = poster
    }
}

extension FullPosterPresenter: FullPosterViewOutput {
    func viewDidLoad() {
        let originalURL = MoviesDBProvider.Poster.original.url(for: poster)
        input?.update(poster: originalURL)
    }
    
    func didClose() {
        router.dismiss()
    }
}
