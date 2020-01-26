//
//  MoviesViewController.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

final class MovieListViewController: UIViewController {
    
    private var presenter: MoviesPresenterProtocol?
    private let screenTitle = "Movies"
    private var filteredMovieList = [Movie]()
    private var movieList = [Movie]()
    private var currentPage = 1
    private var totalPages = 1
    private var isLoadMoreGoingOn = false
    private var searchBarActivated = false
    lazy var searchBar:UISearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        title = screenTitle
        configureSearchBar()
        createViews()
        setupConstraints()
        presenter?.loadVideos(page: currentPage)
    }

    private func configureSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.minimumLineSpacing = 0
        viewLayout.minimumInteritemSpacing = 0
        let layoutWidth = view.frame.width/3
        let layoutHeight = layoutWidth * 1.5
        viewLayout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        
        return viewLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = Colors.backgroundColor
        view.delegate = self
        view.dataSource = self
        view.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "ABCD")
        return view
    }()
    
    private func createViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    //    MARK: - Delegate Calls -
    func setPresenter(presenter: MoviesPresenterProtocol) {
        self.presenter = presenter
    }

    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ABCD", for: indexPath) as! MovieCollectionViewCell
        
        let movie = filteredMovieList[indexPath.row]
        let viewData = MovieCollectionViewCell.ViewData(posterImageUrl: movie.posterPath)
        cell.updateCollectionViewCell(with: viewData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= self.filteredMovieList.count - 5 && totalPages > currentPage && !isLoadMoreGoingOn && !searchBarActivated {
            isLoadMoreGoingOn = true
            self.presenter?.loadVideos(page: currentPage + 1)
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = filteredMovieList[indexPath.row]
        presenter?.showMovieDetails(movie: movie)
    }
}

extension MovieListViewController : MoviesViewProtocol {
    func showError(error: MoviesAppError) {
        // TODO: Handle proper Error here
        isLoadMoreGoingOn = false
    }
    
    func updateMovieList(movieListResponse: MovieListResponse) {
        currentPage = movieListResponse.page
        totalPages = movieListResponse.totalPages
        filteredMovieList = self.filteredMovieList + movieListResponse.results
        movieList = filteredMovieList
        updateCollectionView()
        isLoadMoreGoingOn = false
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarActivated = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filteredMovieList = movieList
        collectionView.reloadData()
        deActivateSearchBar()
    }
    
    // Note : - I have only focus on logic for Search hence not concentrated on Code reusable and hardcoding and loops. We can fix all these by spending some more time on it.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text! == "" {
            filteredMovieList = movieList
        } else {
            let array = searchBar.text?.lowercased().components(separatedBy: " ")
            for text in array! {
                filteredMovieList = movieList.filter{ movie in
                    let arrayOfTitleTexts = movie.title.lowercased().components(separatedBy: " ")
                    for titleText in arrayOfTitleTexts {
                        if titleText.count < text.count || text == "" {
                            continue
                        }
                        if titleText.substring(to: text.count-1) == text {
                            return true
                        }
                    }
                    return false
                }
            }
        }
        collectionView.reloadData()
        deActivateSearchBar()
    }
    
    private func deActivateSearchBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.searchBarActivated = false
        }
    }
}

extension String {
    func substring(to : Int) -> String {
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
}
