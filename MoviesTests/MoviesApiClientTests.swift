//
//  MoviesApiClientTests.swift
//  MoviesTests
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesApiClientTests: XCTestCase {

    func testThatFetchNowPlayingMoviesReturnsMovies() {
        let filepath = Bundle.init(for: MoviesApiClientTests.self).path(forResource: "mockMoviesResponse", ofType: "json")
        let contents = try! String(contentsOfFile: filepath!)
        let jsondata = contents.data(using: .utf8)

        let mockURLSession = MockURLSession(data: jsondata, urlResponse: nil, error: nil)
        let apiClient = MoviesApiClient(session: mockURLSession)
        let moviesExpectation = expectation(description: "movies")
        var moviesResponse: [Movie]?
        
        apiClient.fetchNowPlayingMovies(page: 1) { (result) in
            switch result {
            case .success(let response):
                moviesResponse = response.results
                XCTAssertEqual(response.page, 1)
                XCTAssertEqual(response.totalPages, 58)
                XCTAssertEqual(response.totalResults, 1147)
            case .failure(_):
                break
            }
            moviesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(moviesResponse)
            let movie = moviesResponse?[0]
            XCTAssertEqual(movie?.title, "Ad Astra")
        }
    }
}

class MockURLSession: URLSession {
    var cachedUrl: URLRequest?
    private let mockTask: MockTask
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error:
            error)
    }
        
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = request
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let errorObj: Error?
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.errorObj = error
    }
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler?(self.data, self.urlResponse, self.errorObj)
        }
    }
}
