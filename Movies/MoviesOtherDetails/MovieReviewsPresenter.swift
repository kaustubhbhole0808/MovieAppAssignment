//
//  MovieReviewsPresenter.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//

import Foundation

final class MovieReviewsPresenter {
    
    private weak var viewController: MovieReviewsViewProtocol?
    private let interactor: MovieReviewsInteractorProtocol
    private var movieId: Int!

    init(viewController: MovieReviewsViewProtocol,
         interactor: MovieReviewsInteractorProtocol,
         movieId: Int) {
        self.viewController = viewController
        self.interactor = interactor
        self.movieId = movieId
    }
}

extension MovieReviewsPresenter : MovieReviewsPresenterProtocol {
    func fetchReviews() {
        interactor.fetchReviewsFromServer(movieId: self.movieId) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.viewController?.updateMovieReviewsOnView(reviews: response)
                case .failure(let error):
                    // FixMe: - show Proper Error message on screen
                    print(error.localizedDescription)
                }
            }
        }
    }
}

