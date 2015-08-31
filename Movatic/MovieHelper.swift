//
//  File.swift
//  Movatic
//
//  Created by Bhaskar Maddala on 8/30/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import Foundation

class MovieHelper {
    var movie = [:]
    var serviceConfig = [:]
    init(movie: NSDictionary, serviceConfig: NSDictionary) {
        self.movie = movie
        self.serviceConfig = serviceConfig
    }
    
    func imagesBaseUrlString() -> String? {
        let imagesConfig = serviceConfig["images"] as? NSDictionary
        if let imagesConfig = imagesConfig {
            let imgRoot = imagesConfig["base_url"] as? String
            return imgRoot
        }
        return nil
    }
    
    func posterUrl(posterPath: String) -> String? {
        if let base = imagesBaseUrlString() {
            let posterUrl = base + "w92" + posterPath
            return posterUrl
        }
        return nil
    }
    
    func posterNSURL() -> NSURL? {
        let posterPath = self.movie["poster_path"] as? String
        if let posterPath = posterPath {
            if let posterUrl = self.posterUrl(posterPath) {
                return NSURL(string: posterUrl)
            }
        }
        return nil
    }
    
    func backdropUrl(backdropPath: String) -> String? {
        if let base = imagesBaseUrlString() {
            let backdropUrl = base + "w1280" + backdropPath
            return backdropUrl
        }
        return nil
    }
    
    func backdropNSURL() -> NSURL? {
        let backdropPath = self.movie["backdrop_path"] as? String
        if let backdropPath = backdropPath {
            if let backdropUrl = self.backdropUrl(backdropPath) {
                return NSURL(string: backdropUrl)
            }
        }
        return nil
    }
    
    func title() -> String? {
        return movie["title"] as? String
    }
    
    func synopsis() -> String? {
        return movie["overview"] as? String
    }
}