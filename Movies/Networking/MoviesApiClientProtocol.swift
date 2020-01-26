//
//  MoviesApiClientProtocol.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

protocol MoviesApiClientProtocol {
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void)
    func fetchSimillarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void)
    func fetchReviews(movieId: Int, completion: @escaping (Result<MovieReviewsResponse, MoviesAppError>) -> Void)
    func fetchCredits(movieId: Int, completion: @escaping (Result<MovieCreditsResponse, MoviesAppError>) -> Void)

}

