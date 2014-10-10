//
//  HomeTimeLineViewController.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/6/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import Accounts
import Social


class HomeTimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets : [Tweet]?
    var currentTweet : Tweet?
    var twitterAccount : ACAccount?
    var networkController : NetworkController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // load custom cell from nib
        self.tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CustomCell")
        self.tableView.estimatedRowHeight = 75.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        // make AppDelegate a singleton
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        // talk to network controller and call it's method to fetch tweets
        self.networkController.fetchTimeLine("home", userScreenName: "") { (errorDescription, tweets) -> (Void) in
            if errorDescription != nil {
                // there is a problem
            } else {
                self.tweets = tweets
                self.tableView.reloadData()
            }
        }
    }


    
    
    
    //MARK:Tableview Stuff
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create new cell
        var cell : CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomTableViewCell
        
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
