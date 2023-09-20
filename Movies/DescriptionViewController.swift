//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    private let descriptionView = DescriptionView()
    var posterImage: UIImage?
    
    override func loadView() {
        view = descriptionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        navigationItem.title = "Title"
        
        setupTapGestureRecognizer()
        
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        descriptionView.imageView.isUserInteractionEnabled = true
        descriptionView.imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func imageViewTapped() {
        let fullPosterVC = FullPosterViewController()
        fullPosterVC.posterImage = posterImage
        present(fullPosterVC, animated: true)
    }
}
