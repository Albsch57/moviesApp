//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import UIKit

class MovieCardViewController: UIViewController {
    
    private let movieCardView = MovieCardView()
    private var movieCardViewModel: MovieCardViewModel! = nil {
        didSet {
            movieCardView.imageView.setPosterFromMovieDB(of: movieCardViewModel.imageUrl)
            movieCardView.descriptionLabel.text = movieCardViewModel.description
            movieCardView.nameLabel.text = movieCardViewModel.title
            movieCardView.countryLabel.text = movieCardViewModel.countries.joined(separator: ", ")
            movieCardView.genreLabel.text = movieCardViewModel.genre.joined(separator: ", ")
            movieCardView.ratingLabel.text = String ("Rating: \(movieCardViewModel.rating)")
            movieCardView.trailerButton.isHidden = movieCardViewModel.trailer == nil
        }
    }
    
    var presenter: MovieCardViewOutput?
    
    override func loadView() {
        view = movieCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        navigationItem.title = "Title"
        
        setupTapGestureRecognizer()
        configureTapActionForTrailierButton()
        presenter?.viewDidLoad()
    }
    
    private func configureTapActionForTrailierButton() {
        movieCardView.trailerButton.addAction(.init(handler: { [weak self] _ in
            guard let videoPlatform = self?.movieCardViewModel.trailer else { return }
            self?.presenter?.showTrailer(from: videoPlatform)
        }), for: .touchUpInside)
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        movieCardView.imageView.isUserInteractionEnabled = true
        movieCardView.imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func imageViewTapped() {
       
    }
}

extension MovieCardViewController: MovieCardViewInput {
    func update(viewState: ViewState<MovieCardViewModel>) {
        switch viewState {
        case .loading:
            break
        case .movie(let movie):
            movieCardViewModel = movie
        case .error(let massage):
            break
        default: break
        }
    }
}

