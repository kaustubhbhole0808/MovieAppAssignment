//
//  CreditsTableViewController.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//

import UIKit

class MovieCreditsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var creditsTableView: UITableView!
    private var presenter: MovieCreditsPresenterProtocol?
    private var credits = [MovieCredits]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchCredits()
        configureTableView()
    }

    func setPresenter(presenter: MovieCreditsPresenterProtocol) {
        self.presenter = presenter
    }

    private func configureTableView() {
        creditsTableView.delegate = self
        creditsTableView.dataSource = self
        creditsTableView.allowsSelection = false
        creditsTableView.separatorStyle = .none
        creditsTableView.backgroundColor = Colors.backgroundColor
        self.creditsTableView.register(UINib(nibName: Xibs.MovieCreditsTableViewCell, bundle: Bundle(for: MovieCreditsViewController.self)), forCellReuseIdentifier: Xibs.MovieCreditsTableViewCell)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.credits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Xibs.MovieCreditsTableViewCell, for: indexPath) as? MovieCreditsTableViewCell else {
            fatalError("Can't load cell")
        }
        let credit = credits[indexPath.row]
        let viewData = MovieCreditsTableViewCell.ViewData(posterImageUrl: credit.profile_path, characterName: credit.name, characterDescription: credit.character)
        cell.updateTableViewCell(with: viewData)
        return cell
    }
}

extension MovieCreditsViewController: MovieCreditsViewProtocol {
    func updateMovieCreditsOnView(credits: MovieCreditsResponse) {
        self.credits = credits.cast
        self.creditsTableView.reloadData()
    }
}
