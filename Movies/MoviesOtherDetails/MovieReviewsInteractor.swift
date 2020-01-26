//
//  MovieReviewsInteractor.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//

import Foundation

final class MovieReviewsInteractor {
    private let client: MoviesApiClientProtocol
    
    init(apiclient: MoviesApiClientProtocol) {
        self.client = apiclient
    }
}

extension MovieReviewsInteractor: MovieReviewsInteractorProtocol {
    func fetchReviewsFromServer(movieId: Int, completion: @escaping (Result<MovieReviewsResponse, MoviesAppError>) -> Void) {
        client.fetchReviews(movieId: movieId) { result in
            completion(result)
        }
    }
}

