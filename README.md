# Movatic Box Office Demo

Time spent: Unaccounted

Completed user stories:

 * [x] Required: User can view a list of latest box office movies including title, cast and tomatoes rating
 * [x] Required: User can view movie details by tapping on a cell.
 * [x] Required: User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at. Used `pod 'SVProgressHUD'`
 * [x] Required: User sees error message when there's a networking error. You may not use UIAlertView or a 3rd party library to display the error. 
 * [x] Required: User can pull to refresh the movie list. Guide: Using UIRefreshControl
 * [x] Optional: Add a tab bar for Box Office and DVD.
 
# Additional Requirements

 * [x] Required: Must use Cocoapods.
 * [x] Required: Asynchronous image downloading must be implemented using the UIImageView category in the AFNetworking library.

# Notes:

[The Movie DB API](https://www.themoviedb.org/documentation/api) was used for real content for all tabs. Made use of `pod 'JLTMDbClient'` to access The Movie DB API

Walkthrough of all implemented features. Wireless was disconnect when loading a view to demonstrate error message. Duration approximately 1:30 min

![Video Walkthrough](movatic.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).
