//
//  MoviesListInteractorTests.swift
//  MoviesTests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesListInteractorTests: XCTestCase {

    func testThatInteractorShouldCallFetchVideos() {
        let apiClient = MockApiClient()
        let interactor = MovieListInteractor(apiclient: apiClient)
        
        interactor.fetchVideos(page: 0) { (result) in
            switch result {
                case .success(_):
                    XCTAssertEqual(apiClient.isFetchNowPlayingMoviesCalled, true)
                case .failure(_):
                    break
            }
        }
    }
}

class MockApiClient: MoviesApiClientProtocol {
    var isFetchNowPlayingMoviesCalled = false
    var isFetchSimillarMoviesCalled = false
    
    func fetchReviews(movieId: Int, completion: @escaping (Result<MovieReviewsResponse, MoviesAppError>) -> Void) {
    }
    
    func fetchCredits(movieId: Int, completion: @escaping (Result<MovieCreditsResponse, MoviesAppError>) -> Void) {
    }
    
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        isFetchNowPlayingMoviesCalled = true
        completion(.success(MovieListResponse.init(results: [], page: 1, totalResults: 1, totalPages: 1)))
    }
    
    func fetchSimillarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        isFetchSimillarMoviesCalled = true
        completion(.success(MovieListResponse.init(results: [], page: 1, totalResults: 1, totalPages: 1)))
    }
}
