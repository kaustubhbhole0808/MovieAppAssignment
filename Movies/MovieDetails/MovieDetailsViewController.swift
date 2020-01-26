//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Kaustubh on 28/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailsViewController: UIViewController {
    
    private var presenter: MovieDetailsPresenterProtocol?
    private var simillarMoviesList = [Movie]()
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieDetailsContainerView: UIView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieYearlabel: UILabel!
    @IBOutlet weak var tabBarContainerView: UIView!
    
    private var creditsViewController: MovieCreditsViewController!
    private var reviewsViewController: MovieReviewsViewController!
    
    var movieDetail: MovieDetailVewModel!
    
    enum Segment: Int {
        case SimillarMovies
        case Reviews
        case Credits
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraSimillarMoviesCollectionView()
        presenter?.displayContentOnScreen()
        self.createCreditsTableViewController()
        self.createReviewsTableViewController()
    }
    
    private func createCreditsTableViewController() {
        let creditsVc = presenter?.createCreditsViewController()
        creditsViewController = creditsVc
        add(asChildViewController: creditsViewController)
        creditsViewController.view.isHidden = true
    }
    
    private func createReviewsTableViewController() {
        let reviewsVc = presenter?.createReviewsViewController()
        reviewsViewController = reviewsVc
        add(asChildViewController: reviewsViewController)
        reviewsViewController.view.isHidden = true
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        tabBarContainerView.addSubview(viewController.view)
        viewController.view.frame = tabBarContainerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
    
    private func configuraSimillarMoviesCollectionView() {
        moviesCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "ABCD")
    }

    private func showHideViewInTabBarContainer(selectedIndex: Int) {
        moviesCollectionView.isHidden = true
        creditsViewController.view.isHidden = true
        reviewsViewController.view.isHidden = true
        switch selectedIndex {
        case Segment.SimillarMovies.rawValue:
            moviesCollectionView.isHidden = false
        case Segment.Reviews.rawValue:
            reviewsViewController.view.isHidden = false
        case Segment.Credits.rawValue:
            creditsViewController.view.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        showHideViewInTabBarContainer(selectedIndex: sender.selectedSegmentIndex)
    }
    
    //  MARK: - Delegate Calls -
    func setPresenter(presenter: MovieDetailsPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    
    func updateViewWithData(movieDetail: MovieDetailVewModel) {
        presenter?.loadSimillarVideos(movieId: movieDetail.id)
        movieNameLabel.text = movieDetail.movieName
        movieDescriptionLabel.text = movieDetail.movieDescription
        movieYearlabel.text = movieDetail.movieYear
    
        guard let posterUrl = movieDetail.posterImageUrl, let url = URL(string: Constants.imageBaseUrl + posterUrl) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                }
            }
        }
    }
    
    // Error response
    func showError(error: MoviesAppError) {
        //TODO: Handle error response here
    }
    
    // Success Response
    func updateSimillarMoviesList(movieList: MovieListResponse) {
        self.simillarMoviesList = movieList.results
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simillarMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ABCD", for: indexPath) as! MovieCollectionViewCell
        
        let movie = simillarMoviesList[indexPath.row]
        let viewData = MovieCollectionViewCell.ViewData(posterImageUrl: movie.posterPath)
        cell.updateCollectionViewCell(with: viewData)
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = simillarMoviesList[indexPath.row]
        presenter?.showMovieDetails(movie: movie)
    }
}
