//
//  MoviesFactory.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

public enum MoviesFactory {
    
    public static func makeMoviesViewController(navigationController: UINavigationController?) -> UIViewController {
        let viewController = MovieListViewController()
        let apiClient = MoviesApiClient(session: URLSession.shared)
        let interactor = MovieListInteractor(apiclient: apiClient)
        var router: MoviesRouter
        
        if let navController = navigationController {
            router = MoviesRouter(navController: navController)
        } else {
            router = MoviesRouter(navController: MoviesFactory.createNavController(viewController))
        }
        
        let presenter = MovieListPresenter(viewController: viewController,
                                           interactor: interactor,
                                           router: router)
        viewController.setPresenter(presenter: presenter)
        return viewController
    }
    
    private static func createNavController(_ viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
}
