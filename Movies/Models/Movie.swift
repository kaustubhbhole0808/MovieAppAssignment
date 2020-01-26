//
//  Movie.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let posterPath: String?
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let backdropPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
}

struct MovieListResponse: Decodable {
    let results: [Movie]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct MovieReviewsResponse: Decodable {
    let results: [MovieReviews]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct MovieCreditsResponse: Decodable {
    let cast: [MovieCredits]
}

struct MovieReviews: Decodable {
    let author: String
    let content: String
    let url: String
}

struct MovieCredits: Decodable {
    let character: String
    let name: String
    let profile_path: String
}

