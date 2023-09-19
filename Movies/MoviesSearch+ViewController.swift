//
//  MoviesSearchViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

class MoviesSearchViewController: UIViewController {
    
    private var movieData: [MovieCollectionViewCellModel] = []
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Title"
        view.backgroundColor = .systemGroupedBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.setCollectionViewLayout(makeCompositionalLayout(), animated: false)
        
        let movie1 = MovieCollectionViewCellModel(title: "Food, 2023", image: UIImage(named: "Food")!, genre: ["Action", "Adventure"], rating: 4.5)
        let movie2 = MovieCollectionViewCellModel(title: "Movie 2", image: UIImage(named: "Food")!, genre: ["Comedy", "Drama"], rating: 3.8)
        let movie3 = MovieCollectionViewCellModel(title: "Movie 2", image: UIImage(named: "Food")!, genre: ["Comedy", "Drama"], rating: 3.8)
        movieData = [movie1, movie2, movie3]
        
        makeLayout()
    }
}

extension MoviesSearchViewController {
    private func makeLayout() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

extension MoviesSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseId, for: indexPath) as! MovieCollectionViewCell
        
        let movie = movieData[indexPath.item]
        movie.configure(cell)
        
        return cell
    }
    
    
}

extension MoviesSearchViewController: UICollectionViewDelegate {
    
}

extension MoviesSearchViewController {
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
  //      section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
