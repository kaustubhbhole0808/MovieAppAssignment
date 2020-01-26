//
//  MovieDetailsProtocol.swift
//  Movies
//
//  Created by Kaustubh on 28/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

protocol MovieDetailsPresenterProtocol {
    func loadSimillarVideos(movieId: Int)
    func displayContentOnScreen()
    func showMovieDetails(movie: Movie)
    func createCreditsViewController() -> MovieCreditsViewController
    func createReviewsViewController() -> MovieReviewsViewController
}

protocol MovieDetailsInteractorProtocol: class {
    func fetchSimillarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void)
}

protocol MovieDetailsViewProtocol: class {
    func updateViewWithData(movieDetail: MovieDetailVewModel)
    func showError(error: MoviesAppError)
    func updateSimillarMoviesList(movieList: MovieListResponse)
}

protocol MovieReviewsPresenterProtocol {
    func fetchReviews()
}

protocol MovieReviewsInteractorProtocol: class {
    func fetchReviewsFromServer(movieId: Int, completion: @escaping (Result<MovieReviewsResponse, MoviesAppError>) -> Void)
}

protocol MovieReviewsViewProtocol: class {
    func updateMovieReviewsOnView(reviews: MovieReviewsResponse)
}

protocol MovieCreditsPresenterProtocol {
    func fetchCredits()
}

protocol MovieCreditsInteractorProtocol: class {
    func fetchCreditsFromServer(movieId: Int, completion: @escaping (Result<MovieCreditsResponse, MoviesAppError>) -> Void)
}

protocol MovieCreditsViewProtocol: class {
    func updateMovieCreditsOnView(credits: MovieCreditsResponse)

}

