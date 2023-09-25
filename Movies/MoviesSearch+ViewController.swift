//
//  MoviesSearchViewController.swift
//  Movies
//
//  Created by Alyona Bedrosova on 18.09.2023.
//

import UIKit

final class MoviesSearchViewController: UIViewController {

    var presenter: MovieSearchViewOutput?
    private let searchBar = UISearchBar()
    private let emptyResultView = EmptyResultsView()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: PopularMovieCollectionViewCell.reuseId)
        return collectionView
    }()
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "POPULAR_MOVIE_TITLE".localized
        
        setupUI()
        configureSearchBar()
        configureSortingButton()
        presenter?.viewDidLoad()
    }
}

// MARK: - Private methods
private extension MoviesSearchViewController {
    func setupUI() {
        // Set system background
        view.backgroundColor = .systemGroupedBackground
        
        // Configure collection view
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        collectionView.frame = view.bounds
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        collectionView.backgroundView = emptyResultView
        
        // Refrech Control
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        
        // Add subviews
        view.addSubview(collectionView)
    }
    
    @objc
    private func didPullToRefresh(_ sender: UIRefreshControl) {
        presenter?.refreshData()
    }
    
    func configureSortingButton() {

        let sortedPopular = UIAction(title: "FILTER_POPULAR".localized, state: .on) { [weak presenter] _ in
            presenter?.changeSortState(state: .descending)
        }
        
        let sortedUnpopular = UIAction(title: "FILTER_NOT_POPULAR".localized) { [weak presenter] _ in
            presenter?.changeSortState(state: .ascending)
        }
        
        
        sortedPopular.image = .init(systemName: "arrow.down")
        sortedUnpopular.image = .init(systemName: "arrow.up")
        
        let menu = UIMenu(options: .singleSelection, children: [sortedPopular, sortedUnpopular])
        let filterButton = UIBarButtonItem(image: .init(systemName: "line.3.horizontal.decrease"), menu: menu)
        
        navigationItem.rightBarButtonItem = filterButton
    }
    
    func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "SEARCH".localized
        searchController.definesPresentationContext = true
        searchController.extendedLayoutIncludesOpaqueBars = true
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // MARK: CollectionViewLayout
    var collectionViewLayout: UICollectionViewCompositionalLayout {
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

// MARK: - MoviesSearchViewInput
extension MoviesSearchViewController: MoviesSearchViewInput {
    func update(viewState: ViewState<Movie>) {
        switch viewState {
        case .loading:
            collectionView.backgroundView = emptyResultView
        case .content(_):
            collectionView.reloadData()
            collectionView.backgroundView = collectionView.numberOfItems(inSection: 0) == 0 ? emptyResultView : nil
            
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
            
        case .error(let message):
            alert(title: "Error", message: message) { alert in
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
            }
        }
    }
}


// MARK: - UICollectionViewDataSource
extension MoviesSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.reuseId, for: indexPath) as! PopularMovieCollectionViewCell
        let movie = presenter?.item(for: indexPath.row)
        movie?.configure(cell)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MoviesSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didTap(index: indexPath.row)
    }
}

// MARK: - Prefetching items for collection view
extension MoviesSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row == (presenter?.numberOfItems ?? 0) - 2 }) {
            presenter?.prefetchMovies()
        }
    }
}

// MARK: - SearchBarDelegate
extension MoviesSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.didTapSearch(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.didTapSearch(with: "")
    }
}
