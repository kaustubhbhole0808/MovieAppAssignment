//
//  ReviewsViewController.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//

import UIKit

class MovieReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet var reviewsTableView: UITableView!
    private var presenter: MovieReviewsPresenterProtocol?
    private var reviews = [MovieReviews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.fetchReviews()
    }
    
    func setPresenter(presenter: MovieReviewsPresenterProtocol) {
        self.presenter = presenter
    }

    private func configureTableView() {
        reviewsTableView.delegate = self
        reviewsTableView.allowsSelection = false
        reviewsTableView.dataSource = self
        reviewsTableView.separatorStyle = .none
        reviewsTableView.backgroundColor = Colors.backgroundColor
        self.reviewsTableView.register(UINib(nibName: Xibs.ReviewsTableViewCell, bundle: Bundle(for: MovieReviewsViewController.self)), forCellReuseIdentifier: Xibs.ReviewsTableViewCell)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Xibs.ReviewsTableViewCell, for: indexPath) as? ReviewsTableViewCell else {
            fatalError("Can't load cell")
        }
        let review = reviews[indexPath.row]
        let viewData = ReviewsTableViewCell.ViewData(posterImageUrl: review.url, content: review.content, author: review.author)
        cell.updateTableViewCell(with: viewData)
        return cell
    }
}

extension MovieReviewsViewController: MovieReviewsViewProtocol {
    func updateMovieReviewsOnView(reviews: MovieReviewsResponse) {
        self.reviews = reviews.results
        self.reviewsTableView.reloadData()
    }
}
