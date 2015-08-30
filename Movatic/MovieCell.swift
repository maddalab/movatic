//
//  MovieCell.swift
//  Movatic
//
//  Created by Bhaskar Maddala on 8/30/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    var helper: MovieHelper? = nil
    var serviceConfig: NSDictionary = [:]

    func initialize(helper: MovieHelper) {
        self.helper = helper
        
        self.movieTitleLabel.text = helper.title()
        self.movieDescriptionLabel.text = helper.synopsis()
        if let posterUrl = helper.posterNSURL() {
            self.moviePosterImageView.setImageWithURL(posterUrl)
        } else {
            NSLog("Unable to load movie poster")
        }
    }
}
