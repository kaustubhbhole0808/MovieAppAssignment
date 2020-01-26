//
//  MovieDetailsPresenterTests.swift
//  MoviesTests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest
@testable import Movies

class MovieDetailsPresenterTests: XCTestCase {

    func testThatPresenterShouldCallLoadSimillarVideos() {
        
        let viewController = MockMovieDetailsViewController()
        let interactor = MockMovieDetailsInteractor()
        let router = MockMoviesRouter()
        let movie = Movie(posterPath: nil, id: 12, title: "Stars", overview: "xyz", releaseDate: "08", backdropPath: nil)
        
        let presenter = MovieDetailsPresenter(viewController: viewController, interactor: interactor, router: router, movie: movie)
        presenter.displayContentOnScreen()
        XCTAssertEqual(viewController.updateViewDataCalled, true)
        
        presenter.loadSimillarVideos(movieId: 1)
        XCTAssertEqual(interactor.fetchSimillarMoviesCalled, true)
        XCTAssertEqual(viewController.isUpdateSimillarMoviesListCalled, true)
        
        presenter.showMovieDetails(movie: movie)
        XCTAssertEqual(router.navigateToVideoDetailsCalled, true)
    }
}

class MockMovieDetailsInteractor: MovieDetailsInteractorProtocol {
    var fetchSimillarMoviesCalled = false
    
    func fetchSimillarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        fetchSimillarMoviesCalled = true
        completion(.success(MovieListResponse(results: [], page: 1, totalResults: 1, totalPages: 1)))
    }
}

class MockMovieDetailsViewController: MovieDetailsViewProtocol {
    var updateViewDataCalled = false
    var isUpdateSimillarMoviesListCalled = false
    
    func updateViewWithData(movieDetail: MovieDetailVewModel) {
        updateViewDataCalled = true
    }
    
    func showError(error: MoviesAppError) {
    }
    
    func updateSimillarMoviesList(movieList: MovieListResponse) {
        isUpdateSimillarMoviesListCalled = true
    }
    
    
}
