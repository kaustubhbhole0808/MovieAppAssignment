//
//  MovieDetailsInteractor.swift
//  Movies
//
//  Created by Kaustubh on 28/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

final class MovieDetailsInteractor {
    private let client: MoviesApiClientProtocol
    
    init(apiclient: MoviesApiClientProtocol) {
        self.client = apiclient
    }
}

extension MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    
    func fetchSimillarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        client.fetchSimillarMovies(movieId: movieId) { (result) in
            completion(result)
        }
    }
}
