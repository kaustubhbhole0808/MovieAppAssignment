//
//  MovieCreditsTableViewCell.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//

import UIKit

class MovieCreditsTableViewCell: UITableViewCell {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurePersonImageView()
    }

    private func configurePersonImageView() {
        personImageView.layer.cornerRadius = personImageView.frame.width/2
        personImageView.backgroundColor = UIColor.red
    }
}

extension MovieCreditsTableViewCell {
    struct ViewData {
        let posterImageUrl: String?
        let characterName: String
        let characterDescription: String
    }
    
    func updateTableViewCell(with viewData: ViewData) {
        self.characterDescriptionLabel.text = "Role: " + viewData.characterDescription
        self.personNameLabel.text = viewData.characterName
        guard let posterPath = viewData.posterImageUrl, let url = URL(string: Constants.imageBaseUrl + posterPath) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.personImageView.image = image
                    }
                }
            }
        }
    }
}
