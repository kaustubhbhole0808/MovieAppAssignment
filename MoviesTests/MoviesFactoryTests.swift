//
//  MoviesFactoryTests.swift
//  MoviesTests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesFactoryTests: XCTestCase {

    func testThatMoviesFactoryShouldNotReturnNil() {
        
        let movieListController = MoviesFactory.makeMoviesViewController(navigationController: nil)
        XCTAssertNotNil(movieListController)
        
        let movieListControllerWithWithNavController = MoviesFactory.makeMoviesViewController(navigationController: UINavigationController())
        XCTAssertNotNil(movieListControllerWithWithNavController)
    }
}
