//
//  NetworkController.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/8/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import Accounts
import Social

class NetworkController {
    var twitterAccount : ACAccount?
    let imageQueue = NSOperationQueue()

    

    init() {
        
    }
    
    
    func fetchTimeLine(homeOrUser: String, userScreenName: String, completionHandler: (errorDescription: String?, tweets: [Tweet]?) -> (Void)) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
            if granted {
                let accounts = accountStore.accountsWithAccountType(accountType)
                self.twitterAccount = accounts.first as ACAccount?
                
                // set up twitter request for either Home or User
                var url : NSURL?
                var parameters: Dictionary<String, String>?
                if homeOrUser == "home" {
                    url = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
                    parameters = nil
                } else if homeOrUser == "user" {
                    url = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
                    parameters = ["screen_name": userScreenName]
                } else {
                    // error
                }
                let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url, parameters: parameters)
                twitterRequest.account = self.twitterAccount
                
                // this happens on an arbitrary thread
                twitterRequest.performRequestWithHandler({ (data, httpResponse, error) -> Void in
                    // first log out the status code
                    println(httpResponse.description)
                    
                    // switch statement to handle the various status code possibilities
                    switch httpResponse.statusCode {
                    case 200...299:
                        // download JSON from twitter and create tweets from the data
                        let tweets = Tweet.parseJSONDataIntoTweets(data)
                        // this shifts back to the main thread
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            completionHandler(errorDescription: nil, tweets: tweets)
                        })
                    case 400...499:
                        println("client's fault")
                        completionHandler(errorDescription: "client's fault", tweets: nil)
                    case 500...599:
                        println("server's fault")
                        completionHandler(errorDescription: "server failure", tweets: nil)
                    default:
                        println("unexpected result")
                    }
                })
            }
        }
    }
    



    
    func downloadImage(tweet : Tweet, completionHandler: (image: UIImage) -> Void) {
        self.imageQueue.addOperationWithBlock { () -> Void in

            // this alters the stored avatarURLString in order to download a bigger version of the profile pic
            var urlString = tweet.avatarURLString.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let url = NSURL(string: urlString)
            
            // network call to get the image data
            let imageData = NSData(contentsOfURL: url)
            // create UIImage
            let image = UIImage(data: imageData)
            // store image
            tweet.profileImage = image
            // return to main queue and send back the image
            // HOW DOES THIS RETURN THE IMAGE???
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler(image: image)
            })
        }
    }
}