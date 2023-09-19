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
        imageView.contentMode = .center
        return imageView
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    var genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MovieCollectionViewCell {
    private func makeLayout() {
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(genresLabel)
        contentView.addSubview(ratingLabel)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            title.topAnchor.constraint(equalTo: image.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 8),
            
            genresLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -8),
            genresLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 8),
            
            ratingLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -8),
      //      ratingLabel.leadingAnchor.constraint(equalTo: genresLabel.trailingAnchor, constant: 8),
            ratingLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -8)
        ])
    }
}
