//
//  MoviesRouter.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

final class MoviesRouter {
    
    private var moviesNavController: UINavigationController
    
    init(navController: UINavigationController) {
        self.moviesNavController = navController
    }
}

extension MoviesRouter: RouterProtocol {
    
    func navigateToVideoDetailsScreen(movie: Movie) {
        let storyBoard = UIStoryboard(name: Storyboard.MovieDetails, bundle: Bundle(for: MovieDetailsViewController.self))
       
        guard let movieDetailsVc = storyBoard.instantiateInitialViewController() as? MovieDetailsViewController else {
            return
        }
        
        let apiClient = MoviesApiClient(session: URLSession.shared)
        let interactor = MovieDetailsInteractor(apiclient: apiClient)
        let presenter = MovieDetailsPresenter(viewController: movieDetailsVc,
                                              interactor: interactor,
                                              router: self,
                                              movie: movie)
        movieDetailsVc.setPresenter(presenter: presenter)
        moviesNavController.pushViewController(movieDetailsVc, animated: true)
    }
    
}
