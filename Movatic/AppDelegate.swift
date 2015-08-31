//
//  AppDelegate.swift
//  Movatic
//
//  Created by Bhaskar Maddala on 8/30/15.
//  Copyright (c) 2015 Bhaskar Maddala. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func initializeWithConfiguration(tabBarController: UITabBarController) {
        
        // initialize the api client
        let movieClient = JLTMDbClient.sharedAPIInstance()
        movieClient.APIKey = "c4ea245752c4d484f7fc05d79ab142e5"
        
        movieClient.GET("configuration", withParameters: nil) { (response, error) -> Void in
            if let response: AnyObject = response {
                NSLog("Loaded service Config")
                let serviceConfig = response as! NSDictionary
                
                var storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                var popularNavigationController = self.instantiateTabViewController(movieClient, storyboard: storyboard, serviceConfig: serviceConfig, fetchUrl: "movie/popular", title: "Popular Movies")
                
                var topRatedNavigationController = self.instantiateTabViewController(movieClient, storyboard: storyboard, serviceConfig: serviceConfig, fetchUrl: "movie/top_rated", title: "Top Rated")
                
                tabBarController.viewControllers = [popularNavigationController, topRatedNavigationController]
            }
        }
    }

    func instantiateTabViewController(movieClient: JLTMDbClient, storyboard: UIStoryboard, serviceConfig: NSDictionary, fetchUrl: String, title: String) -> UINavigationController {
        var navigationController = storyboard.instantiateViewControllerWithIdentifier("MovaticNavicationViewController") as! UINavigationController
        navigationController.tabBarItem.title = title
        
        var moviesViewController = navigationController.topViewController as! MovaticMoviesViewController
        moviesViewController.movieClient = movieClient
        moviesViewController.serviceConfig = serviceConfig
        moviesViewController.fetchUrl = fetchUrl
        moviesViewController.title = title
        
        return navigationController
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarController = UITabBarController()
        
        initializeWithConfiguration(tabBarController)
        window?.rootViewController = tabBarController
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

