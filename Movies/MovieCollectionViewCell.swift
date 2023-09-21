//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "collectionCell"
    
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return imageView
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textColor = UIColor.white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    var genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = UIColor.white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 10.0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = UIColor.white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 10.0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = bounds
    }
}


extension MovieCollectionViewCell {
    
    private func configureSubviews() {
        [image, title, genresLabel, ratingLabel].forEach {
            contentView.addSubview($0)
            
            if $0 != image {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        makeShadow()
    }
    
    private func makeShadow() {
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: 8, height: 8)).cgPath
        layer.shouldRasterize = true
    }
    
    private func makeConstraints() {
        contentView.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        let layoutGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            

            genresLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            genresLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
//            genresLabel.widthAnchor.constraint(equalToConstant: 200),


            ratingLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            
            
        ])
        
        
        
//        genresLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        genresLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        ratingLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
