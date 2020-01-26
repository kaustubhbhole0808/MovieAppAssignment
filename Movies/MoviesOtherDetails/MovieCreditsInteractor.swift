//
//  MovieCreditsInteractor.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//

final class MovieCreditsInteractor {
    private let client: MoviesApiClientProtocol
    
    init(apiclient: MoviesApiClientProtocol) {
        self.client = apiclient
    }
}

extension MovieCreditsInteractor: MovieCreditsInteractorProtocol {
    func fetchCreditsFromServer(movieId: Int, completion: @escaping (Result<MovieCreditsResponse, MoviesAppError>) -> Void) {
        client.fetchCredits(movieId: movieId) { result in
            completion(result)
        }
    }
}


