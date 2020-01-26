//
//  ModelsTests.swift
//  MoviesTests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest
@testable import Movies

class ModelsTests: XCTestCase {

    func testMoviesModelInitialization() {
        let movie = Movie(posterPath: "/abc.jpg",
                          id: 123,
                          title: "STAR WARS",
                          overview: "This is description",
                          releaseDate: "12/12/2019",
                          backdropPath: "/xyz.png")
        XCTAssertNotNil(movie)
        XCTAssertNotNil(movie.backdropPath)
        XCTAssertNotNil(movie.id)
    }
    
    func testMovieDetailVewModel() {
        let movieDetail = MovieDetailVewModel(id: 123, movieName: "Star Wars", posterImageUrl: nil, movieYear: "12-08-1990", movieDescription: "This is description")
        XCTAssertNotNil(movieDetail)
        XCTAssertEqual(movieDetail.movieName, "Star Wars")
        XCTAssertNotEqual(movieDetail.movieYear, "12/08/1998")
    }
}
