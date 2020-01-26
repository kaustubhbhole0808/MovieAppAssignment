//
//  MoviesApiClient.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

final class MoviesApiClient {
    private let urlSession: URLSession
    
    init(session: URLSession) {
        self.urlSession = session
    }
    
    func fetch<T: Decodable>(page: Int, url: String, completion: @escaping (Result<T, MoviesAppError>) -> Void ) {
        
        var components = URLComponents(string: url)
        components?.queryItems = [URLQueryItem(name: QueryParam.apiKey, value: Constants.apiKey),
                                  URLQueryItem(name: QueryParam.language, value: Constants.language),
                                  URLQueryItem(name: QueryParam.page, value: String(page)) ]
        
        guard let urlComponent = components,
            let finalUrl = urlComponent.url else {
                completion(.failure(MoviesAppError.badRequest))
                return
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let errorObj = error {
                completion(.failure(MoviesAppError.httpError(errorObj.localizedDescription)))
                return
            }
            guard let responseData = data else {
                completion(.failure(MoviesAppError.nodata))
                return
            }
            do {
                let responseInfo =  try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(responseInfo))
            } catch {
                completion(.failure(MoviesAppError.jsonParsingError))
                return
            }
        }
        task.resume()
    }
}

extension MoviesApiClient: MoviesApiClientProtocol {
    func fetchReviews(movieId: Int, completion: @escaping (Result<MovieReviewsResponse, MoviesAppError>) -> Void) {
        let url = Constants.baseUrl + "/" + String(movieId) + MoviesEndPoints.reviews
        fetch(page: 1, url: url, completion: completion) // FixMe:- For now page is Hard coded
    }
    
    func fetchCredits(movieId: Int, completion: @escaping (Result<MovieCreditsResponse, MoviesAppError>) -> Void) {
        let url = Constants.baseUrl + "/" + String(movieId) + MoviesEndPoints.credits
        fetch(page: 1, url: url, completion: completion) // FixMe:- For now page is Hard coded
    }
    
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        let url = Constants.baseUrl + MoviesEndPoints.nowPlaying
        fetch(page: page, url: url, completion: completion)
    }
    
    func fetchSimillarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, MoviesAppError>) -> Void) {
        let url = Constants.baseUrl + "/" + String(movieId) + MoviesEndPoints.simillerMovies
        fetch(page: 1, url: url, completion: completion)
    }
}
