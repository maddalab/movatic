//
//  MovaticMainViewController.swift
//  Movatic
//
//  Created by Bhaskar Maddala on 8/30/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import UIKit

class MovaticMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    var movies: NSDictionary = [:]
    var currentPage: Int = 0
    var serviceConfig: NSDictionary = [:]
    var movieClient: JLTMDbClient!
    var fetchUrl: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setBackgroundColor(UIColor.blackColor().colorWithAlphaComponent(0.5))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setViewForExtension(self.view)
        SVProgressHUD.show()
        
        movieClient.GET(fetchUrl, withParameters: nil) { (response, error) -> Void in
            if let response: AnyObject = response {
                self.currentPage = 0
                self.movies = response as! NSDictionary
                SVProgressHUD.showSuccessWithStatus("")
            } else {
                self.movies = [:]
                SVProgressHUD.showErrorWithStatus("")
            }
            self.moviesTableView.reloadData()
        }
        // set up the table view data source and delegate
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
    }
    
    // IMPLEMENTATION of UITableDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        moviesTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // IMPLEMENTATION of UITableViewDataSources methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result: AnyObject = self.movies["results"] {
            return (result as! NSArray).count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movies = self.movies["results"] as! NSArray?
        if let movies = movies {
            let index = indexPath.row
            if movies.count > index {
                let currentMovie = movies[index] as! NSDictionary
                cell.initialize(MovieHelper(movie: currentMovie, serviceConfig: serviceConfig))
            }
        }
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! MovieCell
        let controller = segue.destinationViewController as! MovaticDetailsViewController
        controller.helper = cell.helper
    }
}
