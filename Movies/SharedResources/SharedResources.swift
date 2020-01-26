//
//  SharedResources.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//
import UIKit

enum Constants {
    static let baseUrl = "https://api.themoviedb.org/3/movie"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    static let apiKey = "08903b022dea52fead9af161e595f07b"
    static let language = "en-US"
}

enum Colors {
    static let backgroundColor = UIColor(red: 37/255, green: 52/255, blue: 66/255, alpha: 1)
}

enum MoviesEndPoints {
    static let nowPlaying = "/now_playing"
    static let simillerMovies = "/similar"
    static let reviews = "/reviews"
    static let credits = "/credits"
}

enum QueryParam {
    static let apiKey = "api_key"
    static let language = "language"
    static let page = "page"
}

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

enum MoviesAppError: Error {
    case badRequest
    case nodata
    case jsonParsingError
    case httpError(String?)
}

enum Storyboard {
    static let MovieDetails = "MovieDetails"
}

enum Xibs {
    static let MovieCreditsTableViewCell = "MovieCreditsTableViewCell"
    static let ReviewsTableViewCell = "ReviewsTableViewCell"
}
