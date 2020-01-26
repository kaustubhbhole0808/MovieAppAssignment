//
//  MovieListPresenterTests.swift
//  MoviesTests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest
@testable import Movies

class MovieListPresenterTests: XCTestCase {
    
    func testThatPresenterObjShouldCallShowMovieDetailsAndLoadVideos() {
        let vc = MockViewController()
        let interactor = MockMovieListInteractor()
        let presenter = MovieListPresenter(viewController: vc, interactor: interactor, router: MockMoviesRouter())
        
        presenter.loadVideos(page: 0)
        let movie = Movie(posterPath: nil, id: 12, title: "Star", overview: "xyz", releaseDate: "12-02-1991", backdropPath: nil)
        
        presenter.showMovieDetails(movie: movie)
        XCTAssertNotNil(presenter)
        XCTAssertEqual(vc.isUpdateMovieListCalled, true)
        XCTAssertEqual(interactor.isFetchVideosCalled, true)
    }
}

class MockMovieListInteractor: MoviesInteractorProtocol {
    var isFetchVideosCalled = false
    
    func fetchVideos(page: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        isFetchVideosCalled = true
        completion(.success(MovieListResponse(results: [], page: 1, totalResults: 1, totalPages: 1)))
    }
}

class MockMoviesRouter: RouterProtocol {
    
    var navigateToVideoDetailsCalled = false
    func navigateToVideoDetailsScreen(movie: Movie) {
        navigateToVideoDetailsCalled = true
    }
}

class MockViewController: MoviesViewProtocol {
    
    var isShowErrorCalled = false
    var isUpdateMovieListCalled = false
    
    func showError(error: MoviesAppError) {
        isShowErrorCalled = true
    }
    
    func updateMovieList(movieListResponse: MovieListResponse) {
        isUpdateMovieListCalled = true
    }
}
