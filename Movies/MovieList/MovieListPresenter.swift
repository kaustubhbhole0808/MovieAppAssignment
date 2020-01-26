//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

final class MovieListPresenter {
    
    private weak var viewController: MoviesViewProtocol?
    private let interactor: MoviesInteractorProtocol
    private let router: RouterProtocol
    
    init(viewController: MoviesViewProtocol,
         interactor: MoviesInteractorProtocol,
         router: RouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
}

extension MovieListPresenter: MoviesPresenterProtocol {
    
    func loadVideos(page: Int) {
        interactor.fetchVideos(page: page) { (result) in
            switch result {
            case .success(let response):
                self.viewController?.updateMovieList(movieListResponse: response)
            case .failure(let error):
                self.viewController?.showError(error: error)
            }
        }
    }
    
    func showMovieDetails(movie: Movie) {
        router.navigateToVideoDetailsScreen(movie: movie)
    }
}
