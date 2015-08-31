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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
