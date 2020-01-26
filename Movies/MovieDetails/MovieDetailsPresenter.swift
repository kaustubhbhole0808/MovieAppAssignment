//
//  MovieDetailsPresenter.swift
//  Movies
//
//  Created by Kaustubh on 28/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailsPresenter {
    
    private weak var viewController: MovieDetailsViewProtocol?
    private let interactor: MovieDetailsInteractorProtocol
    private let router: RouterProtocol
    private var movie: Movie!
    
    init(viewController: MovieDetailsViewProtocol,
         interactor: MovieDetailsInteractorProtocol,
         router: RouterProtocol,
         movie: Movie) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    func createCreditsViewController() -> MovieCreditsViewController {
        let storyBoard = UIStoryboard(name: Storyboard.MovieDetails, bundle: Bundle(for: MovieDetailsViewController.self))
        guard let creditsVc = storyBoard.instantiateViewController(withIdentifier: "CreditsViewController") as? MovieCreditsViewController else {
            fatalError("Controller not Instantiated properly")
        }
        
        let apiClient = MoviesApiClient(session: URLSession.shared)
        let interactor = MovieCreditsInteractor(apiclient: apiClient)
        let presenter =  MovieCreditsPresenter(viewController: creditsVc,
                                               interactor: interactor,
                                               movieId: self.movie.id)
        creditsVc.setPresenter(presenter: presenter)
        return creditsVc
    }
    
    func createReviewsViewController() -> MovieReviewsViewController {
        let storyBoard = UIStoryboard(name: Storyboard.MovieDetails, bundle: Bundle(for: MovieDetailsViewController.self))
        guard let reviewsVc = storyBoard.instantiateViewController(withIdentifier: "ReviewsViewController") as? MovieReviewsViewController else {
            fatalError("Controller not Instantiated properly")
        }
        
        let apiClient = MoviesApiClient(session: URLSession.shared)
        let interactor = MovieReviewsInteractor(apiclient: apiClient)
        let presenter =  MovieReviewsPresenter(viewController: reviewsVc,
                                               interactor: interactor,
                                               movieId: self.movie.id)
        reviewsVc.setPresenter(presenter: presenter)
        return reviewsVc
    }
    
    func displayContentOnScreen() {
        let movieDetailViewModel = MovieDetailVewModel(id: movie.id,
                                                       movieName: movie.title,
                                                       posterImageUrl: movie.backdropPath,
                                                       movieYear: movie.releaseDate,
                                                       movieDescription: movie.overview)
        
        self.viewController?.updateViewWithData(movieDetail: movieDetailViewModel)
    }
    
    func loadSimillarVideos(movieId: Int) {
        interactor.fetchSimillarMovies(movieId: movieId) { (result) in
            switch result {
            case .success(let movieList):
                self.viewController?.updateSimillarMoviesList(movieList: movieList)
            case .failure(let error):
                self.viewController?.showError(error: error)
            }
        }
    }
    
    func showMovieDetails(movie: Movie) {
        router.navigateToVideoDetailsScreen(movie: movie)
    }
}
