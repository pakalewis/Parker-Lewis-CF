//
//  TweetViewController.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var retweets: UILabel!
    @IBOutlet weak var favorited: UILabel!

    var tweet: Tweet?
    var userTweetsArray : [Tweet]?
    var networkController : NetworkController!

    
    
    override func viewDidLoad() {
        // populate items with the data from the Tweet property
        self.imageButton.setImage(self.tweet?.profileImage, forState: .Normal)
        self.tweetText.text = self.tweet?.text
        self.username.text = self.tweet?.username
        self.retweets.text = "Retweets: \(self.tweet!.retweetCount)"
        self.favorited.text = "Favorited: \(self.tweet!.favoriteCount)"
        
        
        // make AppDelegate a singleton
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
    }
    
    @IBAction func imageButtonPressed(sender: AnyObject) {
        
        
        // push the new viewcontroller
        var userTweetsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UserTweets") as UserTweets
//        userTweetsViewController.tweets = self.userTweetsArray
        userTweetsViewController.currentTweet = self.tweet
        self.navigationController?.pushViewController(userTweetsViewController, animated: true)
    }
}
