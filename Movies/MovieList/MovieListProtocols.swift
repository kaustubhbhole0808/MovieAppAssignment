//
//  Protocols.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

protocol MoviesInteractorProtocol: class {
    func fetchVideos(page: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void)
}

protocol MoviesPresenterProtocol: class {
    func loadVideos(page: Int)
    func showMovieDetails(movie: Movie)
}

protocol MoviesViewProtocol: class {
    func showError(error: MoviesAppError)
    func updateMovieList(movieListResponse: MovieListResponse)
}

protocol RouterProtocol {
    func navigateToVideoDetailsScreen(movie: Movie)
}

