//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import UIKit

final class MovieCardViewController: UIViewController {
    
    private var movieCardView: MovieCardView {
        view as! MovieCardView
    }
    
    var movieCardViewModel: MovieCardViewModel! = nil {
        didSet {
            navigationItem.title = movieCardViewModel.title
            movieCardView.imageView.setThumbnailPosterFromMovieDB(of: movieCardViewModel, size: .w500)
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
        view = MovieCardView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        
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
        presenter?.showFullPoster(from: movieCardViewModel)
    }
}

extension MovieCardViewController: MovieCardViewInput {
    func update(viewState: ViewState<MovieCardViewModel>) {
        switch viewState {
        case .loading:
            break
        case .content(let movie):
            movieCardViewModel = movie
        case .error(let message):
            alert(title: "Error", message: message) { alert in
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
            }
        }
    }
}

