//
//  MovaticDetailsViewController.swift
//  Movatic
//
//  Created by Bhaskar Maddala on 8/30/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import UIKit

class MovaticDetailsViewController: UIViewController {

    @IBOutlet weak var movieSynopsisText: UITextView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieBackdropImageView: UIImageView!
    var helper: MovieHelper? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        if let helper = helper {
            if let bdUrl = helper.backdropNSURL() {
                self.movieBackdropImageView.setImageWithURL(bdUrl)
            }
            self.movieSynopsisText.text = helper.synopsis()
            self.movieTitleLabel.text = helper.title()
            super.title = helper.title()
        }
    }
}
