//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Kaustubh on 27/12/19.
//  Copyright © 2019 Kaustubh. All rights reserved.
//

import Foundation
import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    private let paddingMargin: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setupConstraints()
        self.backgroundColor = Colors.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createViews() {
        addSubview(posterImageView)
    }

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: paddingMargin),
            posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: paddingMargin),
            posterImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -paddingMargin),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -paddingMargin)
        ])
    }
}

extension MovieCollectionViewCell {
    struct ViewData {
        let posterImageUrl: String?
    }
    
    func updateCollectionViewCell(with viewData: ViewData) {
        guard let posterPath = viewData.posterImageUrl, let url = URL(string: Constants.imageBaseUrl + posterPath) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.posterImageView.image = image
                    }
                }
            }
        }
    }
}
