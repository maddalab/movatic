//
//  MovaticMainViewController.swift
//  Movatic
//
//  Created by Bhaskar Maddala on 8/30/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import UIKit

class MovaticMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    var popularMovies: NSDictionary = [:]
    var currentPage: Int = 0
    var serviceConfig: NSDictionary = [:]
    let movieClient = JLTMDbClient.sharedAPIInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        movieClient.APIKey = "c4ea245752c4d484f7fc05d79ab142e5"
        loadConfiguration()
        movieClient.GET("movie/popular", withParameters: nil) { (response, error) -> Void in
            if let response: AnyObject = response {
                self.currentPage = 0
                self.popularMovies = response as! NSDictionary
            } else {
                self.popularMovies = [:]
            }
            self.moviesTableView.reloadData()
        }
        // set up the table view data source and delegate
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
    }
    
    func loadConfiguration() {
        movieClient.GET("configuration", withParameters: nil) { (response, error) -> Void in
            if let response: AnyObject = response {
                self.serviceConfig = response as! NSDictionary
            }
        }
    }
    
    func imagesBaseUrlString() -> String? {
        let imagesConfig = serviceConfig["images"] as? NSDictionary
        if let imagesConfig = imagesConfig {
            let imgRoot = imagesConfig["base_url"] as? String
            return imgRoot
        }
        return nil
    }
    
    func moviePosterUrl(posterPath: String) -> String? {
        if let base = imagesBaseUrlString() {
            let posterUrl = base + "w92" + posterPath
            return posterUrl
        }
        return nil
    }
    
    // IMPLEMENTATION of UITableViewDataSources methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result: AnyObject = self.popularMovies["results"] {
            return (result as! NSArray).count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movies = self.popularMovies["results"] as! NSArray?
        if let movies = movies {
            let index = indexPath.row
            if movies.count > index {
                let currentMovie = movies[index] as! NSDictionary
                let title = currentMovie["title"] as? String
                let overview = currentMovie["overview"] as? String
                cell.movieTitleLabel.text = title
                cell.movieDescriptionLabel.text = overview
                let posterPath = currentMovie["poster_path"] as? String
                if let posterPath = posterPath {
                    if let posterUrl = moviePosterUrl(posterPath) {
                        if let nsUrl = NSURL(string: posterUrl) {
                            cell.moviePosterImageView.setImageWithURL(nsUrl)
                        }
                    }
                }
            }
        }
        return cell
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
