//
//  ReviewsTableViewCell.swift
//  Movies
//
//  Created by Kaustubh on 25/01/20.
//  Copyright © 2020 Kaustubh. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewerImageView: UIImageView!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension ReviewsTableViewCell {
    struct ViewData {
        let posterImageUrl: String?
        let content: String
        let author: String
    }
    
    func updateTableViewCell(with viewData: ViewData) {
        self.reviewerNameLabel.text = viewData.author
        self.reviewDescriptionLabel.text = viewData.content
        guard let posterPath = viewData.posterImageUrl, let url = URL(string: Constants.imageBaseUrl + posterPath) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.reviewerImageView.image = image
                    }
                }
            }
        }
    }
}
