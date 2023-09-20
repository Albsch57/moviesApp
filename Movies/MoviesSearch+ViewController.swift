//
//  MoviesSearchViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

class MoviesSearchViewController: UIViewController {
    
    private var movieData: [MovieCollectionViewCellModel] = []
    
    var presenter: MovieSearchViewOutput! = nil
    private let searchBar = UISearchBar()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Popular Movies"
        view.backgroundColor = .systemGroupedBackground
        
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        
        collectionView.setCollectionViewLayout(makeCompositionalLayout(), animated: false)
        makeLayout()
        configureSearchBar()
        presenter.viewDidLoad()
        
        sortingMovies()
        
    }
}

extension MoviesSearchViewController {
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
      
        searchController.searchBar.placeholder = "Search"
        searchController.definesPresentationContext = true
        searchController.extendedLayoutIncludesOpaqueBars = true
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension MoviesSearchViewController {
    private func sortingMovies() {

        let sortedPopular = UIAction(title: "Popular", state: .on) { [weak presenter] _ in
            presenter?.changeSortState(state: .descending)
        }
        
        let sortedUnpopular = UIAction(title: "Not Popular") { [weak presenter] _ in
            presenter?.changeSortState(state: .ascending)
        }
        
        
        sortedPopular.image = .init(systemName: "arrow.down")
        sortedUnpopular.image = .init(systemName: "arrow.up")
        
        let menu = UIMenu(options: .singleSelection, children: [sortedPopular, sortedUnpopular])
        
        let filterButton = UIBarButtonItem(image: .init(systemName: "line.3.horizontal.decrease"), menu: menu)
        
        navigationItem.rightBarButtonItem = filterButton
    }
}

extension MoviesSearchViewController: MoviesSearchViewInput {
    func update(viewState: ViewState<MovieCollectionViewCellModel>) {
        switch viewState {
        case .loading:
            break
        case .data(let rows, let page):
            if page == 1 {
                movieData = rows
            } else {
                movieData += rows
            }
            
            collectionView.reloadData()
        case .error(let massage):
            print(massage)
            break
        }
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
        movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseId, for: indexPath) as! MovieCollectionViewCell
        
        let movie = movieData[indexPath.row]
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(235))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension MoviesSearchViewController: UICollectionViewDataSourcePrefetching {
    // для тех элементов который вот-вот должны будут показаны
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: shouldLoadNextPage) {
            // Проверка условия для подгрузки новых моделей
            presenter.prefetchMovies()
        }
    }
    
    // jтменить загрузку для определенных элементов
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        //
    }
    
    private func shouldLoadNextPage(for indexPath: IndexPath) -> Bool {
        //нужно ли подгружать след страницу если на предпоследней то пора загружать данные
        indexPath.row == movieData.count - 2
    }
}

extension MoviesSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didTapSearch(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearch(with: "")
    }
}
