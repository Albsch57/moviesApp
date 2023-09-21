//
//  FullPosterViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 20.09.2023.
//

import UIKit
import SDWebImage

final class FullPosterViewController: UIViewController {
    
    var presenter: FullPosterViewOutput! = nil
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10
        scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        image.clipsToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.addSubview(imageView)
        scrollView.frame = view.bounds
        imageView.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.delegate = self
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        presenter.viewDidLoad()
    }
    
    @objc
    private func closeButtonTapped() {
        presenter.didClose()
    }
    
}

extension FullPosterViewController: FullPosterViewInput {
    func update(viewState: ViewState<URL>) {
        switch viewState {
        case .loading:
            break
        case .content(let url):
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.large
            imageView.sd_imageIndicator?.indicatorView.tintColor = .red
            imageView.sd_setImage(with: url)
        case .error(let message):
            break
        }
    }
    
}

extension FullPosterViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
