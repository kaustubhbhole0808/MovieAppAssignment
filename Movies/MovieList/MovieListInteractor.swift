//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

final class MovieListInteractor: MoviesInteractorProtocol {
    
    private let client: MoviesApiClientProtocol
    
    init(apiclient: MoviesApiClientProtocol) {
        self.client = apiclient
    }
    
    func fetchVideos(page: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        client.fetchNowPlayingMovies(page: page) { (result) in
            completion(result)
        }
    }
}
