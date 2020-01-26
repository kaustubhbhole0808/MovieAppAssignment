//
//  MovieCreditsPresenter.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//
import Foundation

final class MovieCreditsPresenter {
    private weak var viewController: MovieCreditsViewProtocol?
    private let interactor: MovieCreditsInteractorProtocol
    private var movieId: Int!
    
    init(viewController: MovieCreditsViewProtocol,
         interactor: MovieCreditsInteractorProtocol,
         movieId: Int) {
        self.viewController = viewController
        self.interactor = interactor
        self.movieId = movieId
    }
}

extension MovieCreditsPresenter : MovieCreditsPresenterProtocol {
    func fetchCredits() {
        interactor.fetchCreditsFromServer(movieId: self.movieId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let credits):
                    self.viewController?.updateMovieCreditsOnView(credits: credits)
                case .failure(let error):
                    //FixMe:- Handle Proper Error message
                    print(error.localizedDescription)
                }
            }
        }
    }
}

