//
//  UserTweets.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/9/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class UserTweets: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var tweets : [Tweet]?
    var currentTweet : Tweet?
    var networkController : NetworkController!
    
    var refreshControl = UIRefreshControl()

    
    // add property to ensure that when showing a user's timeline from a specif tweet, that you can show another tweet VC but then not go further down to the user's timeline once again. instead force them to use the back button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // make AppDelegate a singleton
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        
        // load custom cell from nib
        self.tableview.registerNib(UINib(nibName: "CustomTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CustomCell")
        self.tableview.estimatedRowHeight = 75.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        
        
        // set up header view stuff
        self.headerImage.image = self.currentTweet?.profileImage
        self.usernameLabel.text = self.currentTweet?.username
        self.handleLabel.text = "@\(self.currentTweet!.screen_name)"
        self.followersLabel.text = "\(self.currentTweet!.followersCount) followers"
        
        
        // download the user's tweets and store in userTweetsArray
        self.networkController.fetchTimeLine(nil, userScreenName: currentTweet!.screen_name, completionHandler: { (errorDescription, tweets) -> (Void) in
            if errorDescription != nil {
                // there is a problem
            } else {
                self.tweets = tweets
                self.tableview.reloadData()
            }
        })

        // set up the refresh control for the pulling down action
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableview.addSubview(refreshControl)
    }
    
    func refresh() {
        // store the id of the top tweet
        var firstTweet = tweets?[0]
        
        // make network call by passing the first tweet as a parameter
        self.networkController.fetchTimeLine(firstTweet, userScreenName: currentTweet!.screen_name, completionHandler: { (errorDescription, refreshedTweets) -> (Void) in
            if errorDescription != nil {
                // there is a problem
            } else {
                self.tweets = refreshedTweets! + self.tweets!
                self.tableview.reloadData()
            }
        })
        self.refreshControl.endRefreshing()
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : CustomTableViewCell = self.tableview.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomTableViewCell
        
        // target the appropriate tweet
        let tweet = self.tweets?[indexPath.row]
        
        // set cell text to be the tweet text
        cell.cellText.text = tweet?.text
        
        // set tweet's image (if not yet downloaded, then call method on network controller
        if tweet?.profileImage != nil {
            cell.cellImage.image = tweet?.profileImage
        } else {
            cell.cellImage.image = tweet?.placeholderProfileImage
            self.networkController.downloadImage(tweet!, completionHandler: { (image) -> Void in
                cell.cellImage.image = image
            })
        }
        return cell
    }

    
    
    // cell selected, current tweet set and passed to new TweetViewController which is displayed
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newTweetViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TweetViewController") as TweetViewController
        self.currentTweet = self.tweets?[indexPath.row]
        newTweetViewController.tweet = self.currentTweet
        self.navigationController?.pushViewController(newTweetViewController, animated: true)
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
    }
}