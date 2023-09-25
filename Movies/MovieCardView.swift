//
//  DescriptionView.swift
//  Movies
//
//  Created by Alyona Bedrosova on 19.09.2023.
//

import UIKit

class MovieCardView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel! = nil
    var countryLabel: UILabel! = nil
    var genreLabel: UILabel! = nil
    
    let trailerButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = .init(systemName: "play.tv.fill")
        configuration.preferredSymbolConfigurationForImage = .init(pointSize: 16, weight: .semibold)
        return UIButton(configuration: configuration)
    }()
    
    var ratingLabel: UILabel! = nil
    
    var descriptionLabel: UILabel! = nil
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: Private Methods
private extension MovieCardView {
    func makeLabel(size: CGFloat, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = numberOfLines
        return label
    }
    
    func setupUI() {
        
        backgroundColor = .systemBackground
        nameLabel = makeLabel(size: 26)
        countryLabel = makeLabel(size: 24)
        genreLabel = makeLabel(size: 24, numberOfLines: 0)
    
        ratingLabel = makeLabel(size: 24)
        
        descriptionLabel = makeLabel(size: 22, numberOfLines: 0)
        
        addSubview(scrollView)
       
        scrollView.addSubview(imageView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(genreLabel)
        
        stackView.addArrangedSubview(trailerButton)
        stackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
        ])

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
    }
}

extension MovieCardView {
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
    }
}
