//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest

class MovieAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }

    func testMoviesUI() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        app.navigationBars["Movies"].buttons["Movies"].tap()
    }
}
