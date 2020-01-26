//
//  MovieDetailsInteractorTests.swift
//  MoviesTests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest
@testable import Movies

class MovieDetailsInteractorTests: XCTestCase {
    
    func testThatInteractorShouldCallFetchSimillarMovies() {
        let apiClient = MockApiClient()
        let interactor = MovieDetailsInteractor(apiclient: apiClient)
        
        interactor.fetchSimillarMovies(movieId: 1) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(apiClient.isFetchSimillarMoviesCalled, true)
                XCTAssertNotNil(response)
            case .failure(_):
                break
            }
        }
    }
}

